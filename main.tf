#main.tf
#defining the provider as aws
provider "aws" {
  region = var.region
}

# Create a Custom VPC
resource "aws_vpc" "rds_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames
  tags                 = var.vpc_tags
}

# Create private subnet
resource "aws_subnet" "priv_one" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = var.priv_one_cidr
  availability_zone = var.az_one

  tags = {
    Name = "Private Subnet one"
  }
}

#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port   = 3306
    to_port     = 3306
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

#create a RDS Database Instance
resource "aws_db_instance" "pumejrds-instance" {
  engine                 = "mysql"
  identifier             = "myrdsinstance"
  allocated_storage      = 20
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "root"
  password               = "root"
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true

  # vpc_config {
  #subnet_ids = [aws_subnet.priv_one.id]
  # Uncomment and Use this below config if you used dynamic count function to create your subnets and comment out the 4 subnets above.
  # [aws_subnet.public_subs.*.id, aws_subnet.private_subs.*.id]
  #}
}

# Create a route table for the private subnet
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = {
    Name = "My VPC Private Subnet Route Table"
  }
}

# Associate the 1st private subnet with the private subnet route table
resource "aws_route_table_association" "private_subnet_route_table_association" {
  subnet_id      = aws_subnet.priv_one.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}