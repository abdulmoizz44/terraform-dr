# Reference existing IAM instance profiles
data "aws_iam_instance_profile" "company" {
  name = "company-Instance-role"
}

data "aws_iam_instance_profile" "Backend" {
  name = "Backend-Web-Instance-role"
}

data "aws_iam_instance_profile" "Webapp" {
  name = "Webapp-prod-Instance-role"
}

resource "aws_ami_copy" "company-staging-ami" {
  name              = "company-staging-ami-copied"
  source_ami_id     = var.web-staging-company-ami
  source_ami_region = "us-east-1"
}


resource "aws_instance" "company_staging" {
  depends_on             = [aws_ami_copy.company-staging-ami]
  ami                    = aws_ami_copy.company-staging-ami.id
  instance_type          = "t3a.small"
  subnet_id              = var.company-private-subnets[0] # Use the first private subnet
  vpc_security_group_ids = [aws_security_group.ec2_company_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.company.name

  tags = {
    "Name" = "company-staging-company-${var.dr-region}"
  }
}
# #---------------------------------------------------------------------------
resource "aws_ami_copy" "company-prod-ami" {
  name              = "company-prod-ami-copied"
  source_ami_id     = var.web-prod-company-ami
  source_ami_region = "us-east-1"
}


resource "aws_instance" "company_prod" {
  depends_on             = [aws_ami_copy.company-prod-ami]
  ami                    = aws_ami_copy.company-prod-ami.id
  instance_type          = "t3a.medium"
  subnet_id              = var.company-private-subnets[0] # Use the first private subnet
  vpc_security_group_ids = [aws_security_group.ec2_company_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.company.name

  tags = {
    "Name"          = "prod-company-Instance-${var.dr-region}"
    "CustomerAlias" = "***"
    "Environment"   = "prod"
    "IaC"           = "true"
  }
}

# #----------------------------------------------------------------------

resource "aws_ami_copy" "backend-prod-ami" {
  name              = "backend-ami-copied"
  source_ami_id     = var.web-prod-backend-ami
  source_ami_region = "us-east-1"
}

#---------------------------------------------------------------------------------
resource "aws_ami_copy" "webapp-prod-ami" {
  name              = "webapp-ami-copied"
  source_ami_id     = var.web-prod-webapp-ami
  source_ami_region = "us-east-1"
  encrypted         = true
}
