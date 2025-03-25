
resource "aws_eip" "nat" {
  associate_with_private_ip = null

  tags = {
    name = "nat-eks"
  }
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    name = "k8s-nat"
  }

  depends_on = [aws_internet_gateway.k8s_vpc_igw]
}
