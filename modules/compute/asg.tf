locals {
  update_env_script = templatefile("${path.module}/update_env.sh.tmpl", {
    db_host      = var.rds-readreplica-endpoint
    elb_dns_name = var.webapp-lb-dns-name
  })
}

resource "aws_launch_template" "backend" {
  name_prefix            = "BackEnd-lt"
  image_id               = aws_ami_copy.backend-prod-ami.id
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.ec2_backend_sg.id]

  user_data = base64encode(local.update_env_script)

  iam_instance_profile {
    name = data.aws_iam_instance_profile.Backend.name
  }
}

resource "aws_autoscaling_group" "backend" {
  name                      = "AutoScalingGroupBackEnd"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  target_group_arns         = [var.backend-tg-arn]
  vpc_zone_identifier       = var.company-private-subnets # Use dynamically created private subnets
  depends_on                = [aws_launch_template.backend]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "company-prod-BackEnd-Instance-${var.dr-region}"
    propagate_at_launch = true
  }
}

locals {
  update_env_production_script = templatefile("${path.module}/update_env_frontend.sh.tmpl", {
    backend_base_url = "http://${var.backend-lb-dns-name}/api/"
  })
}

resource "aws_launch_template" "webapp" {
  name_prefix            = "Webapp-lt"
  image_id               = aws_ami_copy.webapp-prod-ami.id
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.ec2_webapp_sg.id]

  user_data = base64encode(local.update_env_production_script)

  iam_instance_profile {
    name = data.aws_iam_instance_profile.Webapp.name
  }
}

resource "aws_autoscaling_group" "webapp" {
  name                      = "AutoScalingGroupWebapp"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  target_group_arns         = [var.webapp-tg-arn]
  vpc_zone_identifier       = var.company-private-subnets # Use dynamically created private subnets
  depends_on                = [aws_launch_template.webapp]

  launch_template {
    id      = aws_launch_template.webapp.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "company-prod-WebApp-Instance-${var.dr-region}"
    propagate_at_launch = true
  }
}