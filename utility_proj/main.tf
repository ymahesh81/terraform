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

# output "ins_avail" {
#   //value = data.aws_ec2_instance_type_offerings.instype_avail.instance_types
#   value = [for t in data.aws_ec2_instance_type_offerings.instype_avail: t.instance_types ]
# }

output "region_avail" {
    //value = data.aws_ec2_instance_type_offerings.instype_avail.locations
    value = keys({for az , details in data.aws_ec2_instance_type_offerings.instype_avail:  az => details.instance_types})
  
}

output "inst_unavail" {
  value = keys({for az , details in data.aws_ec2_instance_type_offerings.instype_avail: az => details.instance_types if length(details.instance_types) !=0 })
}

output "firstavail" {
  value = keys({for az , details in data.aws_ec2_instance_type_offerings.instype_avail: az => details.instance_types if length(details.instance_types) !=0 }) [0]
}