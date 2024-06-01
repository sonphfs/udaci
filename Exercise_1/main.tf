# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
  }

  backend "s3" {
    bucket = "terraform-codebase"
    key    = "exercise/1/state"
    region = "ap-southeast-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
  profile ="default"
  shared_credentials_files = ["/Users/sonph1704/.aws/credentials"]
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

variable "vpc_id" {
    default = "vpc-072734a0d2c6f7277"
}

variable "public_subnet_1" {
    default = "subnet-033efcb509515f961"
}

variable "public_subnet_2" {
    default = "subnet-014160b48546f4bc9"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "udacity_t2_1" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_1

  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4


resource "aws_instance" "udacity_m4_1" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_1

  tags = {
    Name = "Udacity M4"
  }
}