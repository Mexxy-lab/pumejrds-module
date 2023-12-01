MY NICE and AWESOME TERRAFORM MODULE TO PROVISION RDS MySQL DB WITH CUSTOM VPC ON PRIVATE SUBNET. ----->

module "pumejrds-module" {
source        = "github.com/Mexxy-lab/pumejrds-module.git?ref=v1.0.0"
region        = "us-west-2"
vpc_cidr      = "10.0.0.0/16"
dns_hostnames = true
dns_support   = true
priv_one_cidr = "10.0.1.0/24"
az_one        = "Enter your first az"
vpc_id        = "aws_vpc.rds_vpc.id"
#access_key    = "NA"
#secret_key    = "NA"
}