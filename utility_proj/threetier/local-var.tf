# variable "project_name" {
#   type = string
# }
# variable "environment" {
#   type = string
# }

# variable "common_tags" {
#   type = string
# }
# locals {
#   name-prefix = "${var.project_name}-${var.environment}"
# }

locals {
  common_tags = {
    Name = "devinstance"
    project_name = "eric",
    environment     = "dev"
  }
}