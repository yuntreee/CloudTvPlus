resource "aws_db_subnet_group" "DBSubnetGroup" {
  name = "ctp-dbsubnetgroup-${var.region_name}"
  description = "CTP-DBSubnetGroup-${var.region_name}"
  subnet_ids = [
    var.pri_subnet_a,
    var.pri_subnet_c
  ]
}


# 읽기전용 DB
resource "aws_db_instance" "DB" {
  identifier = "ctp-db-replica"
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  name = "CTPDB"
  storage_type = "gp2"
  multi_az = true
  db_subnet_group_name = "${aws_db_subnet_group.DBSubnetGroup.id}"
  vpc_security_group_ids = ["${aws_security_group.DBSG.id}"]
  skip_final_snapshot = true
  replicate_source_db = var.source_db_arn

}