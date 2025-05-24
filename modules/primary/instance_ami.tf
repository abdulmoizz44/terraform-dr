resource "aws_ami_from_instance" "web-prod-backend" {
  name                    = "company-web-prod-BackEnd-Instance"
  source_instance_id      = "i-0d5f7f01138b1bf84"
  snapshot_without_reboot = true
}

resource "aws_ami_from_instance" "web-prod-webapp" {
  name                    = "company-web-prod-Webapp-Instance"
  source_instance_id      = "i-058fa631cfca0ebb1"
  snapshot_without_reboot = true
}

resource "aws_ami_from_instance" "web-staging-company" {
  name                    = "company-web-staging-company"
  source_instance_id      = "i-0370ff24e6ea6a49d"
  snapshot_without_reboot = true
}

resource "aws_ami_from_instance" "web-prod-company" {
  name                    = "company-web-prod-company"
  source_instance_id      = "i-042c48d2af4735e03"
  snapshot_without_reboot = true
}

data "aws_instance" "web-prod-backend" {
  instance_id = "i-0d5f7f01138b1bf84"
}

data "aws_instance" "web-prod-webapp" {
  instance_id = "i-058fa631cfca0ebb1"
}

data "aws_instance" "web-staging-company" {
  instance_id = "i-0370ff24e6ea6a49d"
}

data "aws_instance" "web-prod-company" {
  instance_id = "i-042c48d2af4735e03"
}
