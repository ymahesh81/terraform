module "public_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  name = "bastion-sg"
  description = "security group for public bastion"
  vpc_id = module.vpc.vpc_id
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  tags = local.common_tags
}
