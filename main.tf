provider "aws" {
  # No need to add since we have added all configuration including region,access_key and secret_access_key via aws configure list command 
  # it is located at ~/.aws/credentials
}

variable "first_subnet_cidr_block_production" {
    description = "Subnet CIDR Block"
}


variable "first_subnet_cidr_block_customer" {
    description = "Subnet CIDR Block"
}

variable "vpc_cidr_block_pro" {
    description = "VPC CIDR Block Pro"
}

variable "vpc_cidr_block_customer" {
    description = "VPC CIDR Block Customer"
}

resource "aws_vpc" "production_network" {
  cidr_block = var.vpc_cidr_block_pro
  tags = {
    "Name" = "Production VPC"
  }
}

resource "aws_vpc" "customer_network" {
  cidr_block = var.vpc_cidr_block_customer
  tags = {
    "Name" = "Customer VPC"
  }
}

data "aws_vpc" "customer_vpc" {
  vpc_id =aws_vpc.customer_network.id
}

data "aws_vpc" "production_vpc" {
  vpc_id =aws_vpc.production_network.id
}

resource "aws_subnet" "first_production_subnet" {
  vpc_id = aws_vpc.production_network.id
  cidr_block = var.first_subnet_cidr_block_production
  availability_zone = "us-east-1b"
    tags = {
    "Name" = "First Production Subnet"
  }
}

resource "aws_subnet" "first_customer_subnet" {
  vpc_id = aws_vpc.customer_network.id
  cidr_block = var.first_subnet_cidr_block_customer
  availability_zone = "us-east-1c"
    tags = {
    "Name" = "First Customer Subnet"
  }
}

resource "aws_subnet" "second_production_subnet" {
  vpc_id = data.aws_vpc.production_vpc
  cidr_block = "172.19.2.0/24"
  availability_zone = "us-east-1b"
    tags = {
    "Name" = "Second Production Subnet"
  }
}

resource "aws_subnet" "second_customer_subnet" {
  vpc_id = data.aws_vpc.customer_vpc
  cidr_block = "172.20.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "Second Customer Subnet"
  }
}
