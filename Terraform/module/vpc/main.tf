# vpc 생성
resource "aws_vpc" "ctpvpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name = "ctp-vpc-${var.region_name}"
    }
}


# public subnet
resource "aws_subnet" "public_subnet_a" {
    vpc_id     = aws_vpc.ctpvpc.id
    cidr_block = var.public_sn_a_cidr
    availability_zone = "${var.region}a"
    tags = {
        Name = "public_subnet_a-${var.region_name}"
    }
}

resource "aws_subnet" "public_subnet_c" {
    vpc_id     = aws_vpc.ctpvpc.id
    cidr_block = var.public_sn_c_cidr
    availability_zone = "${var.region}c"
    tags = {
        Name = "public_subnet_c-${var.region_name}"
    }
}

# private subnet
resource "aws_subnet" "private_subnet_a" {
    vpc_id     = aws_vpc.ctpvpc.id
    cidr_block = var.private_sn_a_cidr
    availability_zone = "${var.region}a"
    tags = {
        Name = "private_subnet_a-${var.region_name}"
    }
}

resource "aws_subnet" "private_subnet_c" {
    vpc_id     = aws_vpc.ctpvpc.id
    cidr_block = var.private_sn_c_cidr
    availability_zone = "${var.region}c"
    tags = {
        Name = "private_subnet_c-${var.region_name}"
    }
}


# internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.ctpvpc.id
    tags = {
        Name = "Internet Gateway ${var.region_name}"
    }
}

# public route
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.ctpvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "ctp-route-1"
    }
}

resource "aws_route_table_association" "route_table_association_1" {
    subnet_id      = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route_table_association_2" {
    subnet_id      = aws_subnet.public_subnet_c.id
    route_table_id = aws_route_table.route_table.id
}

# nat gateway
resource "aws_eip" "nat_1" {
    vpc   = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_eip" "nat_2" {
    vpc   = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_nat_gateway" "nat_gateway_1" {
    allocation_id = aws_eip.nat_1.id

    subnet_id = aws_subnet.public_subnet_a.id

    tags = {
        Name = "NAT-GW-1"
    }

}

resource "aws_nat_gateway" "nat_gateway_2" {
    allocation_id = aws_eip.nat_2.id

    subnet_id = aws_subnet.public_subnet_c.id

    tags = {
        Name = "NAT-GW-2"
    }
}

# private route
resource "aws_route_table" "route_table_private_1" {
    vpc_id = aws_vpc.ctpvpc.id

    tags = {
        Name = "ctp-private-1"
    }
}

resource "aws_route_table" "route_table_private_2" {
    vpc_id = aws_vpc.ctpvpc.id

    tags = {
        Name = "ctp-private-2"
    }
}

resource "aws_route_table_association" "route_table_association_private_1" {
    subnet_id      = aws_subnet.private_subnet_a.id
    route_table_id = aws_route_table.route_table_private_1.id
}

resource "aws_route_table_association" "route_table_association_private_2" {
    subnet_id      = aws_subnet.private_subnet_c.id
    route_table_id = aws_route_table.route_table_private_2.id
}

resource "aws_route" "private_nat_1" {
    route_table_id              = aws_route_table.route_table_private_1.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat_gateway_1.id
}

resource "aws_route" "private_nat_2" {
    route_table_id              = aws_route_table.route_table_private_2.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat_gateway_2.id
}