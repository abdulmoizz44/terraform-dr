#prod-***-ec2-SecurityGroupWebApp

resource "aws_security_group" "ec2_webapp_sg" {
  vpc_id      = var.vpc_id
  description = "EC2 Security Group for WebApp"

  ingress {
    from_port       = 443
    prefix_list_ids = []
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = false
    to_port         = 443
  }

  ingress {
    from_port       = 80
    prefix_list_ids = []
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = false
    to_port         = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = "prod"
    "IaC"           = "true"
    "Name"          = "prod-***-ec2-SecurityGroupWebApp"
  }
}

#prod-***-ec2-SecurityGroupBackEnd

resource "aws_security_group" "ec2_backend_sg" {
  vpc_id      = var.vpc_id
  description = "EC2 Security Group for BackEnd"

  ingress {
    from_port       = 443
    prefix_list_ids = []
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = false
    to_port         = 443
  }

  ingress {
    from_port       = 80
    prefix_list_ids = []
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = false
    to_port         = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = "prod"
    "IaC"           = "true"
    "Name"          = "prod-***-ec2-SecurityGroupBackEnd"
  }
}

#prod-***-ec2-SecurityGroupcompanyServer

resource "aws_security_group" "ec2_company_sg" {
  vpc_id      = var.vpc_id
  description = "EC2 Security Group for company Server"

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = "prod"
    "IaC"           = "true"
    "Name"          = "prod-***-ec2-SecurityGroupcompanyServer"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 32601
    to_port     = 32602
    cidr_blocks = ["10.169.150.95/32"]
  }

  ingress {
    protocol  = "icmp"
    from_port = -1
    to_port   = -1
    cidr_blocks = [
      "10.208.5.0/24",
      "10.169.150.95/32",
    ]
  }

  ingress {
    protocol  = "tcp"
    from_port = 6661
    to_port   = 6662
    cidr_blocks = [
      "10.208.5.0/24",
      "10.169.150.95/32",
    ]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 32601
    to_port     = 32602
    cidr_blocks = ["10.208.5.0/24"]
    description = "FMOLHS Production"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id
  description = "Security group for RDS DB Instance"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}