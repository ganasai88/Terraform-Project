provider "aws" {
  region     = "us-east-1"
}

variable "subnet_cidr_block" {
  description = "This is cidr_block"
  
  type = list(string)
}

variable avail_zone { }

resource "aws_vpc" "develop" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Terra-VPC" 
  }
}

resource "aws_subnet" "new_subnet" {
  vpc_id = aws_vpc.develop.id
  cidr_block = var.subnet_cidr_block[0]
  availability_zone = var.avail_zone
  tags = {
    "Name" = "Terra-Subnet" 
    }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "subnet_exitingvpc" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.120.0/24"
  availability_zone = var.avail_zone
  tags = {
    "Name" = "Default-VPC-Subnet" 
  }
}

output "aws_vpc" {
  value = aws_vpc.develop.id
}

output "aws_subnet" {
  value = aws_subnet.new_subnet.id
}