#---------------------------------------------------------------
# AWS Instance:
#---------------------------------------------------------------
resource "aws_instance" "test_ec2" {
  ami           = var.UBUNTU_18_04
  instance_type = "t2.micro"
  depends_on    = [
    aws_vpc.test_vpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet,
  ]
  provisioner "file" {
    source      = "docker/prometheus.yml"
    destination = "/home/ubuntu/prometheus.yml"
  }
  provisioner "file" {
    source      = "docker/docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install docker.io docker-compose -y",
      "sudo docker-compose up -d"
    ]
  }
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.public_interface
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.private_interface
  }
  tags = {
    Name = "Test Instance"
  }
}

#---------------------------------------------------------------
# Public Interface:
#---------------------------------------------------------------
resource "aws_network_interface" "public_interface" {
  subnet_id = aws_subnet.public_subnet
  tags      = {
    Name = "Test Public Interface"
  }
}

#---------------------------------------------------------------
# Private Interface:
#---------------------------------------------------------------
resource "aws_network_interface" "private_interface" {
  subnet_id = aws_subnet.private_subnet
  tags      = {
    Name = "Test Private Interface"
  }
}
