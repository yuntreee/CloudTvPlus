variable "region" {}

variable "region_name" {}

variable "account_id" {}

# DB 마스터사용자 이름
//variable "db_master_name" {}

# DB 마스터사용자 패스워드
//variable "db_master_pw" {}

variable "pri_subnet_a" {}

variable "pri_subnet_c" {}

variable "vpc_id" {}

# variable "instance_sg" {}

# variable "bastion_sg" {} 
variable "chain_SG" {
  type = list(string)
}

variable "cidr" {
    type = list(string)
}