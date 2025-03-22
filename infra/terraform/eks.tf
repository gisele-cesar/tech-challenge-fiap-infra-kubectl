# IAM role for eks

resource "aws_iam_role" "eks_fiap" {
  name = "eks-cluster-eks-fiap"
  tags = {
    tag-key = "eks-cluster-eks-fiap"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "eks-fiap-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_fiap.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks_fiap" {
  name     = "eks-fiap"
  role_arn = aws_iam_role.eks_fiap.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks-fiap-AmazonEKSClusterPolicy]
}