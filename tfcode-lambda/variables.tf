provider "aws" {
  region = "ap-south-1"
  profile = "mahesh"
}



variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "clouddirty"
}