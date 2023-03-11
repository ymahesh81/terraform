module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  depends_on = [ module.vpc ]
 
  # name = "${local.environment}-vm"
  name = "local.environment"

  ami = data.aws_ami.amzn_linux.id
  instance_type = var.instance_type
  #user_data = file("${path.module}/apache-install.sh")
  user_data = "${file("app1-install.sh")}"
  vpc_security_group_ids = [module.private_sg.security_group_id]
  #instance_count = 2
  count = var.private_instance_count
  key_name = var.instance_keypair
  
  # subnet_id = [
  #   module.vpc.private_subnets[0],
  #   module.vpc.private_subnets[1]
  # ]
  subnet_id = module.vpc.private_subnets[count.index]
 tags = local.common_tags
}