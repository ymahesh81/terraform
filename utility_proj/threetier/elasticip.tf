resource "aws_eip" "bastioneip" {
    depends_on = [
      module.ec2_bastion,
      # module.ec2_private,
      module.vpc
    ]
    instance = module.ec2_bastion.id[0]
    
    vpc = true
    tags = local.common_tags
}

