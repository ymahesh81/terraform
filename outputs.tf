# output "ec2_publicip" {
#   description = "EC2 Instance Public IP"
#   value       = aws_instance.ec2_demo.public_ip
# }

# output "ec2_public_dns" {
#   description = "Ec2 public DNS"
#   value       = aws_instance.ec2_demo.public_dns

# }

output "ec2_public_dns" {
  description = "Ec2 public DNS"
  value = [for instance in aws_instance.ec2_demo: instance.public_dns]
}

##output in maplist

output "ec2_public_ip" {
  description = "EC2 private IP"
  value = {for c,  instance in aws_instance.ec2_demo: c => instance.public_ip}
}

// output with splash operator
output "splat_dns_name" {
  value = aws_instance.ec2_demo[*].public_dns
}