# MY NICE and AWESOME TERRAFORM MODULE TO PROVISION RDS MySQL DB WITH CUSTOM VPC ON A PRIVATE SUBNET. ----->

~~~

module "pumejrds-module" {
source        = "./modules"
version       = "Enter the latest version"
region        = "Enter your region here"
vpc_cidr      = "10.0.0.0/16"
dns_hostnames = false
dns_support   = false
priv_one_cidr = "10.0.1.0/24"
az_one        = "Enter your first az"
vpc_id        = "aws_vpc.rds_vpc.id"
}

~~~