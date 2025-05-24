resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.company-backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }
}

resource "aws_lb_listener" "webapp" {
  load_balancer_arn = aws_lb.company-webapp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-tg.arn
  }
}