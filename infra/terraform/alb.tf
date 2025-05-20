# resource "aws_lb" "k8s_alb" {
#   name               = "fiap-fase-4"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = [
#     aws_subnet.public-us-east-1a.id,
#     aws_subnet.public-us-east-1b.id
#   ]

#   tags = {
#     name = "k8s-alb"
#   }
# }

# resource "aws_lb_target_group" "k8s_tg" {
#   name     = "k8s-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.k8s_vpc.id

#   health_check {
#     interval            = 30
#     path                = "/api/health"
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }

#   tags = {
#     name = "k8s-tg"
#   }
# }

# resource "aws_lb_listener" "k8s_listener" {
#   load_balancer_arn = aws_lb.k8s_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.k8s_tg.arn
#   }
# }

resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = aws_vpc.k8s_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}