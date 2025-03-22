
resource "aws_iam_role" "k8s_role" {
  name = "k8s-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "k8s_role_attachment" {
  role       = aws_iam_role.k8s_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



resource "aws_eks_cluster" "k8s_cluster" {
  name     = "k8s-cluster"
  role_arn = aws_iam_role.k8s_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.k8s_subnet.id]
  }

  depends_on = [aws_iam_role_policy_attachment.k8s_role_attachment]
}

