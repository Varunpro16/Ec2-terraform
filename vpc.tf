
# Data source for default VPC and Subnet
data "aws_vpc" "default" {
  default = true
}