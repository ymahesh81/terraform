terraform {
  //required_version = "3.18"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"

    }
  }
}
provider "aws" {
  region  = "ap-south-1"
  profile = "mahesh"
}

# Availability Zones Datasource
data "aws_availability_zones" "ec2demo_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "instype_avail" {
    for_each = toset(data.aws_availability_zones.ec2demo_azones.names)
  filter {
    name   = "instance-type"
    values = ["t2.small"]
  }

  filter {
    name   = "location"
    values = [each.key]
    
  }

  location_type = "availability-zone"
}

resource "aws_instance" "ec2_demo" {
  ami = data.aws_ami.amzn_linux.id
  //ami = "ami-0b5eea76982371e91"
  //instance_type          = var.instance_type
  //instance_type = var.instance_type_list[0]
  instance_type          = var.instance_type_map["qa"]
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.Allow_SSH.id, aws_security_group.Allow_HTTP.id]
  #for_each               = toset(data.aws_availability_zones.ec2demo_azones.names)
  for_each = toset(keys({for az , details in data.aws_ec2_instance_type_offerings.instype_avail: az => details.instance_types if length(details.instance_types) !=0 }))
  availability_zone      = each.value
  tags = {
    Name = "ec2_demo-${each.key}"
  }
}

