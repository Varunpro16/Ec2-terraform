variable "subnet_zone" {
  description = "Available zones for subnet"
  type        = list(string)
}

variable "instance_ami"{
    description = "AMI of the instance"
    type        = string
}
variable "instance_type" {
    description = "Type of the instance"
    type        = string
}
variable "ebs_vol" {
  description = "Volume of server's EBS"
  type        = number
}
variable "instance_name" {
   description = "Name of the instance"
   type        = string
}
variable "security_gp_name" {
   description = "Name of the security groups"
   type        = string
}
variable "key_pair_name" {
   description = "Name of the key pair"
   type        = string
}