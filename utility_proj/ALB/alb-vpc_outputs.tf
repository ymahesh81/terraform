output "vpc_id" {
  description = "The ID of the VPC"
  #value       = try(vpc.this[0].id, "")
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  #value       = try(vpc.this[0].cidr_block, "")
  value = module.vpc.vpc_cidr_block
}