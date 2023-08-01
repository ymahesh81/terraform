terraform {
  # required_version = "3.18"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"

    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "frescoplay"
}

resource "aws_instance" "ec2_demo" {
  ami = data.aws_ami.amzn_linux.id
#ami = "ami-0b5eea76982371e91"
#instance_type          = var.instance_type
#instance_type = var.instance_type_list[0]
  instance_type =  var.instance_type_map["dev"]
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.Allow_SSH.id, aws_security_group.Allow_HTTP.id]
  count = 2
  tags = {
    Name = "ec2_demo-${count.index}"
  }
}

