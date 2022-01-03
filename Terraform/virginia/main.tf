provider "aws" {
  region  = "us-east-1"
  access_key = ""
  secret_key = ""
}

terraform {
  backend "s3" {
    bucket         = "cloudtv9-apnortheast2-tfstate"
    key            = "aws/virginia/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-cloudtv9"
  }
}

module "vpc" {
  source = "../module/vpc"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  vpc_cidr = "20.0.0.0/16"
  public_sn_a_cidr = "20.0.1.0/24"
  public_sn_c_cidr = "20.0.2.0/24"
  private_sn_a_cidr = "20.0.3.0/24"
  private_sn_c_cidr = "20.0.4.0/24"
}

module "dynamoDB" {
  source = "../module/dynamoDB"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id


  vpc_id = module.vpc.vpc_id
  pub_RT = module.vpc.pub_RT
  pri_RT1 = module.vpc.pri_RT1
  pri_RT2 = module.vpc.pri_RT2
}

module "rds" {
  source = "../module/RDS_Replica"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  vpc_id = module.vpc.vpc_id
  pri_subnet_a = module.vpc.pri_subnet_a
  pri_subnet_c = module.vpc.pri_subnet_c  

  instance_sg = module.web-cluster.instance_sg
  bastion_sg = module.web-cluster.bastion_sg  
  source_db_arn = data.terraform_remote_state.seoul.outputs.db_arn
}

module "web-cluster" {
  source = "../module/web-cluster"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  image_id = "ami-0e2bbf434c383944d"
  instance_type = "t2.micro"

  bastion_key_name = "Virginia_key"
  //db_master_name = "admin"
  //db_master_pw = "1q2w3e4r!"

  vpc_id = module.vpc.vpc_id
  pub_subnet_a = module.vpc.pub_subnet_a
  pub_subnet_c = module.vpc.pub_subnet_c
  pri_subnet_a = module.vpc.pri_subnet_a
  pri_subnet_c = module.vpc.pri_subnet_c
  pub_RT = module.vpc.pub_RT
  pri_RT1 = module.vpc.pri_RT1
  pri_RT2 = module.vpc.pri_RT2
  db_dns_write = data.terraform_remote_state.seoul.outputs.db_dns
  db_dns_read = module.rds.db_dns
  dynamodb_name = module.dynamoDB.dynamodb_name
  acm_certificate = module.acm.acm_certificate
}

module "CICD" {
  source = "../module/CICD"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  GitRepo_name = "CloudTvPlus/WEB"
  autoscaling_group_name = module.web-cluster.autoscaling_group_name
  alb_target_group_name = module.web-cluster.alb_target_group_name
}

module "acm" {
  source = "../module/acm"

  domain_name = var.domain_name
  dns_zone_id = data.terraform_remote_state.seoul.outputs.dns_zone_id
}

resource "aws_globalaccelerator_endpoint_group" "ctp_globalaccelerator_endgroup" {
  listener_arn = data.terraform_remote_state.seoul.outputs.ga_listener
  endpoint_configuration {
    endpoint_id = module.web-cluster.alb_arn
      weight      = 100
  }
}

module "LogBackup" {
  source = "../module/LogBackup"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  n_hours = 4
}