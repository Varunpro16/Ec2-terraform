# Elastic IP

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.elastic_ip.id
}


resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}