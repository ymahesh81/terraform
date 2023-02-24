#public instance - bastion IP
output "ec2_bastion_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_bastion.id
}


output "ec2_bastion_public_dns" {
  description = "List of public IP assigned to the instances"
  value       = module.ec2_bastion[*].public_ip
}

#private instance IP

output "ec2_private_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private[*].id
}


output "ec2_private_public_dns" {
  description = "List of public IP assigned to the instances"
  value       = module.ec2_private[*].public_ip
}