resource "aws_lb" "company-backend" {
  name               = "company-backend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.backend_alb_sg.id]
  subnets            = var.company-public-subnets

  enable_deletion_protection = false

  tags = {
    Environment = "dr"
  }
}

resource "aws_lb" "company-webapp" {
  name               = "company-webapp"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.company-public-subnets

  enable_deletion_protection = false

  tags = {
    Environment = "dr"
  }
}