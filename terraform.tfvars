#terraform.tfvars
region = "us-east-2"
#access_key    = "NA"
#secret_key    = "NA"
vpc_id        = "aws_vpc.rds_vpc.id"
priv_one_cidr = "10.0.1.0/24"
az_one        = "us-east-2a"
vpc_cidr      = "10.0.0.0/16"
dns_support   = "true"
dns_hostnames = "true"