variable "UBUNTU_18_04" {
  description = "Amazon Machine Image ID for Ubuntu Server 18.04"
  default     = "ami-0c6c52a141d029618"
}

variable "REGION" {
  description = "AWS Frankfurt deployment region."
  default     = "eu-central-1"
}

variable "S3_PATH" {
  description = "Enabled S3 path"
  default     = "test-bucket/some/path"
}

variable "HOME_DIR" {
  description = "Home directory in an ec2"
  default     = "/home/ubuntu"
}
