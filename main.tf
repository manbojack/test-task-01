#---------------------------------------------------------------
# AWS Instance:
#---------------------------------------------------------------
resource "aws_instance" "webserver" {
  depends_on = [
    aws_vpc.test_vpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet,
  ]
  ami           = var.AMI_UBUNTU_18_04
  instance_type = "t2.micro"
  tags          = {
    Name = "Webserver_From_Terraform"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install docker.io"
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
}

#---------------------------------------------------------------
# Public Interface:
#---------------------------------------------------------------
resource "aws_network_interface" "public_interface" {
  subnet_id = aws_subnet.public_subnet
}

#---------------------------------------------------------------
# Private Interface:
#---------------------------------------------------------------
resource "aws_network_interface" "private_interface" {
  subnet_id = aws_subnet.private_subnet
}