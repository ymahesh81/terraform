#AWS Region
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

# AWS EC2 Instance Type
variable "bastion_instance_type" {
  description = "EC2 Instance Type for Bastion"
  type        = string
  default     = "t2.small"
}

variable "instance_type" {
  description = "EC2 instance for workloads"
  type = string
  default = "t2.micro"
}
# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "clouddirty"
}

variable "private_instance_count" {
  description = "Instance count for private subnet"
  type = number
  default = 2
}