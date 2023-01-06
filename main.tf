terraform {
  //required_version = "3.18"
  required_providers{
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "aws_instance" "ec2_demo" {
   ami = data.aws_ami.amzn_linux.id
  //ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  key_name = var.instance_keypair
}

# resource "aws_security_group" "ssh_sg" {

# ingress = [ {
#   cidr_blocks = [ "0.0.0.0/0" ]
#   description = "SSH_SG"
#   from_port = 22
#   protocol = "tcp"
#   self = false
#   to_port = 22
# } ]
# egress = [ {
#   cidr_blocks = [ "0.0.0.0/0" ]
#   description = "SSH_SG"
#   from_port = 0
#   protocol = "-1"
#   self = false
#   to_port = 0
#   ipv6_cidr_blocks = ["::/0"]
# } ]
# }