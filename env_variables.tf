#AWS Region
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "clouddirty"
}

variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = [ "t3.micro","t2.micro","t2.small" ]
  
}

variable "instance_type_map" {
  description = "EC2 Instance Map"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa" = "t2.micro"
    "prod" = "t2.small"
  }
}