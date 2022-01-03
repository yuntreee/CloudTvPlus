resource "aws_security_group" "instance" {
    name = "web-security-sg-${var.region_name}"
    vpc_id = var.vpc_id

    ingress {

        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {

        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {

        from_port   = 2049
        to_port     = 2049
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }    
    
    egress {

        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    tags = {
        Name = "web-sg-${var.region_name}"
    }
}

resource "aws_security_group" "lb-sg" {
    name = "lb-security-sg-${var.region_name}"
    vpc_id = var.vpc_id

    ingress {

        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    
    egress {

        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    tags = {
        Name = "lb-sg"
    }
}

# EFS SG
resource "aws_security_group" "efs_sg" {
  name = "CTP-EFSSG-${var.region_name}"
  description = "CTP-EFSSG-${var.region_name}"
  vpc_id = var.vpc_id

  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "efs-sg-${var.region_name}"
  }
}

# bastion sg
resource "aws_security_group" "bastion_sg" {
    name = "bastion-SG-${var.region_name}"
    description = "bastion-SG-${var.region_name}"

    vpc_id = var.vpc_id

    ingress {

        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {

        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}