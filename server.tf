
# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.instance_ami 
  instance_type = var.instance_type            
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = data.aws_subnet.default.id
  associate_public_ip_address = true

  # Security group attachment
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Root volume
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.ebs_vol # 15 GB
    delete_on_termination = false
  }
  user_data = <<EOF
    #!/bin/bash

    sudo apt-get update

    SSHD_SOCKET_PORT="/lib/systemd/system/ssh.socket"

    # Replace the line with Port 2404, if it contains #Port 22
    sed -i 's/^ListenStream=22/ListenStream=4545/' "$SSHD_SOCKET_PORT"

    sudo systemctl daemon-reload

    # Path to the sshd_config file (update with your correct path if needed)
    SSHD_CONFIG_FILE="/etc/ssh/sshd_config"

    # Ensure the file is writable
    sudo chmod +w "$SSHD_CONFIG_FILE"

    # Replace the line with Port 4545 if it contains #Port 22 (account for extra spaces)
    sudo sed -i 's/^#\s*Port 22/Port 4545/' "$SSHD_CONFIG_FILE"

    # Confirmation message
    echo "Port 22 line replaced with Port 4545"

    sudo systemctl restart ssh

    sudo ufw allow 4545/tcp

    sudo ufw delete allow 22/tcp

    sudo iptables -A INPUT -p tcp --dport 4545 -j ACCEPT

    sudo iptables -D INPUT -p tcp --dport 22 -j ACCEPT


    EOF

  tags = {
    Name = var.instance_name
  }
}