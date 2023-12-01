#variables.tf
#variable "access_key" {
#description = "Access key to AWS console"
#}
#variable "secret_key" {
#description = "Secret key to AWS console"
#}
variable "region" {
  description = "AWS region"
}

# Variable for vpc cidr
variable "vpc_cidr" {
  type        = string
  description = "Variable for your vpc cidr block"
}

# Create a variable for your vpc dns support
variable "dns_support" {
  type        = string
  description = "This is a variable for your dns support"
}

# Variable for DNS hostnames
variable "dns_hostnames" {
  type        = string
  description = "This is a variable for my vpc hostnames"
}

# Variable for your VPC_ID
variable "vpc_id" {
  type = string
}

# Varible for private subnet one cidr
variable "priv_one_cidr" {
  type        = string
  description = "cidr for first private subnet"
}

# variable for 1st availability zone
variable "az_one" {
  type        = string
  description = "az for my first public or private subnet"
}

# Variable for vpc tags
variable "vpc_tags" {
  type        = map(string)
  description = "This is the variable for my vpc tags"
  default = {
    Name        = "main_vpc"
    Environment = "Production"
    Team        = "DevOps"
  }
}