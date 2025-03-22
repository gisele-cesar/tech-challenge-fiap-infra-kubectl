resource "aws_internet_gateway" "k8s_vpc_igw" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    name = "k8s_vpc_igw"
  }
}