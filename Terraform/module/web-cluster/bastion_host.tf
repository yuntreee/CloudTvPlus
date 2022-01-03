# ctp-vpc의 리소스들만 s3에 접근 가능하도록 하는 s3 버킷 정책
data "template_file" "db_s3_policy" {
  template = file("${path.module}/json/DB_S3_policy.json")
  vars = {
    dbS3Arn = aws_s3_bucket.db_s3.arn
    VPCID = var.vpc_id
  }
}

resource "aws_s3_bucket" "db_s3" {
  bucket = "ctp-db-${var.region_name}-${var.account_id}"
  acl = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "db_s3_policy_attach" {
  bucket = aws_s3_bucket.db_s3.id
  policy = data.template_file.db_s3_policy.rendered
}

# SQL쿼리문 담긴 파일 S3에 업로드
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.db_s3.id
  key = "query.zip"
  source = "${path.module}/query.zip"
}

# VPC-S3 엔드포인트 게이트웨이
resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_id = var.vpc_id
  route_table_ids = [
    var.pub_RT,
    var.pri_RT1,
    var.pri_RT2
  ]
}

# 배스천 호스트
resource "aws_instance" "bastion" {
  ami           = var.image_id
  instance_type = var.instance_type
  subnet_id = var.pub_subnet_a
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  key_name = var.bastion_key_name
  # S3에서 SQL 쿼리문 다운받아서 실행
  user_data = <<-EOF
                #! /bin/bash
                apt-get -y update
                apt-get -y install mysql-client unzip
                wget https://${aws_s3_bucket.db_s3.id}.s3.ap-northeast-2.amazonaws.com/${aws_s3_bucket_object.object.id}
                unzip ${aws_s3_bucket_object.object.id}

                mysql -u${local.Cloud_DB.admin} -p${local.Cloud_DB.password} -h ${var.db_dns_write} < root_query.sql 
                mysql -u${local.Cloud_DB.admin} -p${local.Cloud_DB.password} -h ${var.db_dns_write} < Video.sql
                mysql -u${local.Cloud_DB.admin} -p${local.Cloud_DB.password} -h ${var.db_dns_write} < Thumbnail.sql
                mysql -u${local.Cloud_DB.admin} -p${local.Cloud_DB.password} -h ${var.db_dns_write} < member.sql
                
                EOF
  tags = {
    Name = "bastion-${var.region_name}"
  }
}

# bastion instance 용 탄력적 ip 할당
resource "aws_eip" "bastion_eip" {
    vpc = true
    instance = aws_instance.bastion.id
}

data "aws_secretsmanager_secret_version" "Cloud_DB" {
  # Fill in the name you gave to your secret
  secret_id = "Cloud_DB"
}

locals {
  Cloud_DB = jsondecode(
    data.aws_secretsmanager_secret_version.Cloud_DB.secret_string
  )
}