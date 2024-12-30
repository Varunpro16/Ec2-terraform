resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.key_pair.public_key_openssh
}
# Save the private key to a local file
resource "local_file" "private_key" {
  filename       = "${path.module}/${var.key_pair_name}.pem" # Save to the current module directory
  content        = tls_private_key.key_pair.private_key_pem
  file_permission = "0600" # Restrict access to the private key
}
# Output the key details
output "private_key" {
  value     = tls_private_key.key_pair.private_key_pem
  sensitive = true
}

output "public_key" {
  value = tls_private_key.key_pair.public_key_openssh
}