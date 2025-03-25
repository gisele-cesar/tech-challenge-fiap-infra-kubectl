# Create a VPC
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    name = "k8s_vpc"
  }
}
