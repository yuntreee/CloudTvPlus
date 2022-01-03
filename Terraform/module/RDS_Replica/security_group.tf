# DB Instance SG
resource "aws_security_group" "DBSG" {
  name = "CTP-DBSG-${var.region_name}-rep"
  description = "CTP-DBSG-${var.region_name}-rep"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${var.instance_sg}", "${var.bastion_sg}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "db-sg-${var.region_name}"
  }
}