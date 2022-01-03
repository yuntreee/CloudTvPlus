provider "aws" {
  region  = "ap-northeast-2"
  access_key = ""
  secret_key = ""
}

terraform {
  backend "s3" {
    bucket         = "cloudtv9-apnortheast2-tfstate"
    key            = "aws/seoul/terraform.tfstate"
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

  vpc_cidr = "10.0.0.0/16"
  public_sn_a_cidr = "10.0.1.0/24"
  public_sn_c_cidr = "10.0.2.0/24"
  private_sn_a_cidr = "10.0.3.0/24"
  private_sn_c_cidr = "10.0.4.0/24"
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
  source = "../module/RDS"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  //db_master_name = "admin"
  //db_master_pw = "1q2w3e4r!"

  vpc_id = module.vpc.vpc_id
  pri_subnet_a = module.vpc.pri_subnet_a
  pri_subnet_c = module.vpc.pri_subnet_c  

  # instance_sg = module.web-cluster.instance_sg
  # bastion_sg = module.web-cluster.bastion_sg  
  chain_SG = ["${module.web-cluster.instance_sg}", 
              "${module.web-cluster.bastion_sg}"]
  cidr = ["20.0.0.0/16"]
}

module "rds_Replica"{
  source = "../module/RDS_Replica"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  vpc_id = module.vpc.vpc_id
  pri_subnet_a = module.vpc.pri_subnet_a
  pri_subnet_c = module.vpc.pri_subnet_c  

  instance_sg = module.web-cluster.instance_sg
  bastion_sg = module.web-cluster.bastion_sg  
  source_db_arn = module.rds.db_arn

}

module "web-cluster" {
  source = "../module/web-cluster"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  image_id = "ami-036ae50e1637bb299"
  instance_type = "t2.micro"

  bastion_key_name = "soldesk"
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
  db_dns_write = module.rds.db_dns
  db_dns_read = module.rds_Replica.db_dns
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

module "video-convert" {
  source = "../module/video-converting"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id
}

module "domain" {
  source = "../module/domain"

  lb_arn = [module.web-cluster.lb_arn]
  domain_name = var.domain_name
}

module "acm" {
  source = "../module/acm"

  domain_name = var.domain_name
  dns_zone_id = module.domain.dns_zone_id
}

module "LogBackup" {
  source = "../module/LogBackup"

  region = var.region
  region_name = var.region_name
  account_id = var.account_id

  n_hours = 4
}