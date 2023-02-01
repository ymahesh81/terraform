output "ec2_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.ec2_demo.public_ip
}

output "ec2_public_dns" {
  description = "Ec2 public DNS"
  value       = aws_instance.ec2_demo.public_dns

}