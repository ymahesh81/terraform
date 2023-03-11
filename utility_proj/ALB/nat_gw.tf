resource "aws_eip" "nat" {
  count = 1
depends_on = [
  module.vpc.public_subnets
]
  vpc = true
}

