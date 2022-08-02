provider "aws" {
  # No need to add since we have added all configuration including region,access_key and secret_access_key via aws configure list command 
  # it is located at ~/.aws/credentials
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "availibility_zone" {}
variable "env_prefix" {}

resource "aws_vpc" "my_app_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "my_app_subnet-1" {
  vpc_id = aws_vpc.my_app_vpc.id
  cidr_block = var.subnet_cidr_block 
  availability_zone = var.availibility_zone
  tags = {
    "Name" = "${var.env_prefix}-subnet-1"
  } 
}
