resource "aws_db_subnet_group" "DBSubnetGroup" {
  name = "ctp-dbsubnetgroup"
  description = "CTP-DBSubnetGroup"

  subnet_ids = [
    var.pri_subnet_a,
    var.pri_subnet_c
  ]
}

resource "aws_db_instance" "DB" {
  identifier = "ctp-db"
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  name = "CTPDB"
  username = local.Cloud_DB.admin
  password = local.Cloud_DB.password
  storage_type = "gp2"
  multi_az = true
  backup_retention_period = 1
  db_subnet_group_name = "${aws_db_subnet_group.DBSubnetGroup.id}"
  #vpc_security_group_ids = ["${aws_security_group.DBSG.id}"]
  vpc_security_group_ids = [aws_security_group.DBSG.id]
  skip_final_snapshot = true
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