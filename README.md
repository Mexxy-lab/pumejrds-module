MY NICE and AWESOME TERRAFORM MODULE TO PROVISION RDS MySQL DB WITH CUSTOM VPC ON PRIVATE SUBNET. ----->

module "pumejrds-module" {
source        = "Mexxy-lab/pumejrds-module/aws"
version       = 1.0.1
region        = "Enter your region here"
vpc_cidr      = "10.0.0.0/16"
dns_hostnames = true
dns_support   = true
priv_one_cidr = "10.0.1.0/24"
az_one        = "Enter your first az"
vpc_id        = "aws_vpc.rds_vpc.id"
#access_key    = "NA"
#secret_key    = "NA"
}