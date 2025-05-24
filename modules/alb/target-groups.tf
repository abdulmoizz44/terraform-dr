resource "aws_lb_target_group" "backend-tg" {

  name        = "company-backend-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "webapp-tg" {

  name        = "company-webapp-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}
