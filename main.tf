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

# Create a security group for the MySQL database
resource "aws_security_group" "mysql_sg" {
  vpc_id = aws_vpc.rds_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add ingress rules as needed
  # Example: Allow MySQL traffic from a specific IP
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create first private subnet
resource "aws_subnet" "priv_one" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = var.priv_one_cidr
  availability_zone       = var.az_one
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet one"
  }
}

# Create second private subnet
resource "aws_subnet" "priv_two" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = var.priv_two_cidr
  availability_zone       = var.az_two
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet two"
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
  password               = "emekulusfechi"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]

  lifecycle {
    ignore_changes = [
      allocated_storage,
      instance_class,
      username,
      password,
    ]
  }

  #vpc_config {
  #subnet_ids = [aws_subnet.priv_one.id]
  # Uncomment and Use this below config if you used dynamic count function to create your subnets and comment out the 4 subnets above.
  # [aws_subnet.public_subs.*.id, aws_subnet.private_subs.*.id]
  #}
}

# Create a DB subnet group for the private subnet
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "my-mysql-subnet-group"
  subnet_ids = [aws_subnet.priv_one.id, aws_subnet.priv_two.id]
}