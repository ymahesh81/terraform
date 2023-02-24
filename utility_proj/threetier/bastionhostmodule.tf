module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"


name = "bastionhost"
#vpc_id = module.vpc.vpc_id[0]
ami = data.aws_ami.amzn_linux.id
instance_type = var.instance_type

key_name = var.instance_keypair
subnet_id = module.vpc.public_subnets[0]
vpc_security_group_ids = [module.public_sg.security_group_id]
tags = local.common_tags

}