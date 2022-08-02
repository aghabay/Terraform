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

resource "aws_internet_gateway" "my_vpc_internet_gateway" {
     vpc_id = aws_vpc.my_app_vpc.id
     tags = {
     "Name" = "${var.env_prefix}-internet-gateway"
   }
}

 resource "aws_route_table" "my_app_route_table" {
   vpc_id = aws_vpc.my_app_vpc.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id =aws_internet_gateway.my_vpc_internet_gateway.id
   }
   tags = {
     "Name" = "${var.env_prefix}-vpc-route-table"
   }
 }