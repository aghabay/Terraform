provider "aws" {
  region = "us-east-1"
  # secret_key = "fnzO1byx4RNqUeZ0gghcY44s3cy7fXhjRV0Kx/dS"
}

variable "subnet_cidr_block" {
    description = "Subnet CIDR Block"
}

variable "vpc_cidr_block" {
    description = "VPC CIDR Block"
}

variable "vpc_description" {
    description = "VPC Description"
}

resource "aws_vpc" "test_environment_vpc" {
  cidr_block = var.vpc_cidr_block
   tags = {
   Name = var.vpc_description
  }
}
 
resource "aws_vpc" "production_environment_vpc" {
  cidr_block = "172.119.0.0/16"
   tags = {
   Name = "Production VPC via Terraform"
  }
}

data "aws_vpc" "to_default_vpc" {
  default = true
}

data "aws_vpc" "test_vpc" {
    id = aws_vpc.test_environment_vpc.id
}

data "aws_vpc" "production_vpc" {
    id = aws_vpc.production_environment_vpc.id
}

resource "aws_subnet" "subnet_one" {
     cidr_block = var.subnet_cidr_block
     vpc_id = aws_vpc.test_environment_vpc.id
     availability_zone = "us-east-1a"
     tags = {
     Name = "Subnet_172.19.19.0/24"
  }
}

resource "aws_subnet" "subnet_two" {
     cidr_block = "172.19.29.0/24"
     vpc_id = aws_vpc.test_environment_vpc.id
     availability_zone = "us-east-1a"
    tags = {
    Name = "Subnet_172.19.29.0/24"
  }
}

resource "aws_subnet" "subnet_three" {
     cidr_block = "172.19.39.0/24"
     vpc_id = aws_vpc.test_environment_vpc.id
     availability_zone = "us-east-1b"
     tags = {
     Name = "Subnet_172.19.39.0/24"
  }
}

resource "aws_subnet" "subnet_172_31_39_0_24" {
    vpc_id = data.aws_vpc.to_default_vpc.id
    cidr_block = "172.31.39.0/24"
    availability_zone = "us-east-1b"
     tags = {
     Name = "Subnet_172.31.39.0/24"
  }
}

resource "aws_subnet" "subnet_172_31_49_0_24" {
    vpc_id = data.aws_vpc.to_default_vpc.id
    cidr_block = "172.31.49.0/24"
    availability_zone = "us-east-1a"
     tags = {
     Name = "Subnet_172.31.49.0/24"
  }
}

resource "aws_subnet" "new_subnet_to_custom_vpc" {
    vpc_id = data.aws_vpc.test_vpc.id
    cidr_block = "172.19.49.0/24"
    availability_zone = "us-east-1a"
     tags = {
     Name = "Subnet_172.31.49.0/24"
  }
}

resource "aws_subnet" "subnet_172_119_0_0_24" {
    vpc_id = data.aws_vpc.production_vpc.id
    cidr_block = "172.119.0.0/24"
    availability_zone = "us-east-1a"
     tags = {
     Name = "Subnet_172.119.0.0/24"
  }
}

resource "aws_subnet" "subnet_172_119_1_0_24" {
    vpc_id = data.aws_vpc.production_vpc.id
    cidr_block = "172.119.1.0/24"
    availability_zone = "us-east-1b"
     tags = {
     Name = "Subnet_172.119.1.0/24"
  }
}