variable "region" {}

variable "region_name" {}

variable "account_id" {}

# DB 마스터사용자 이름
//variable "db_master_name" {}

# DB 마스터사용자 패스워드
//variable "db_master_pw" {}

# 배스천 키
variable "bastion_key_name" {}

variable "vpc_id" {}

variable "pub_subnet_a" {}

variable "pub_subnet_c" {}

variable "pri_subnet_a" {}

variable "pri_subnet_c" {}

variable "pub_RT" {}

variable "pri_RT1" {}

variable "pri_RT2" {}

variable "db_dns_write" {}

variable "db_dns_read" {}

variable "dynamodb_name" {}

variable "acm_certificate" {}

variable "image_id" {}
variable "instance_type" {}