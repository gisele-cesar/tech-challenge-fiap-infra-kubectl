# Create a VPC
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    name = "k8s_vpc"
  }
}

resource "aws_subnet" "k8s_subnet" {
  vpc_id     = aws_vpc.k8s_vpc.id
  cidr_block = "10.0.1.0/24"
}