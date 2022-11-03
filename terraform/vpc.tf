#========================== NYC VPC =============================


# Define a vpc
resource "aws_vpc" "nyc_vpc" {
  cidr_block = "${var.vpc_network_cidr}"
  tags = {
    Name = "${var.nyc_vpc}"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "nyc_ig" {
  vpc_id = "${aws_vpc.nyc_vpc.id}"
  tags = {
    Name = "nyc_ig"
  }
}
# Declare the data source
data "aws_availability_zones" "available" {}

# Public subnet 1
resource "aws_subnet" "public_sn_1" {
  vpc_id = "${aws_vpc.nyc_vpc.id}"
  cidr_block = "${var.public_01_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "public_sn_1"
  }
}

# Public subnet 2
resource "aws_subnet" "public_sn_2" {
  vpc_id = "${aws_vpc.nyc_vpc.id}"
  cidr_block = "${var.public_02_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "public_sn_2"
  }
}

# Routing table for public subnet 1
resource "aws_route_table" "public_sn_rt_1" {
  vpc_id = "${aws_vpc.nyc_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.nyc_ig.id}"
  }
  tags = {
    Name = "public_sn_rt_1"
  }
}

# Associate the routing table to public subnet 1
resource "aws_route_table_association" "public_sn_rt_1_assn" {
  subnet_id = "${aws_subnet.public_sn_1.id}"
  route_table_id = "${aws_route_table.public_sn_rt_1.id}"
}

# Routing table for public subnet 2
resource "aws_route_table" "public_sn_rt_2" {
  vpc_id = "${aws_vpc.nyc_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.nyc_ig.id}"
  }
  tags = {
    Name = "public_sn_rt_2"
  }
}

# Associate the routing table to public subnet 2
resource "aws_route_table_association" "public_sn_rt_2_assn" {
  subnet_id = "${aws_subnet.public_sn_2.id}"
  route_table_id = "${aws_route_table.public_sn_rt_2.id}"
}

# ECS Instance Security group
resource "aws_security_group" "public_sg" {
  name = "public_sg"
  description = "Public access security group"
  vpc_id = "${aws_vpc.nyc_vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_01_cidr}",
      "${var.public_02_cidr}"]
  }

  egress {
    # allow all traffic to private SN
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}
