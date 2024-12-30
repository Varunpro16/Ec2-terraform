data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  # Add an additional filter, e.g., availability zone
  filter {
    name   = "availability-zone"
    values = var.subnet_zone # Replace with your desired AZ
  }
}