resource "aws_vpc" "company_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "IaC"           = "true"
    "Environment"   = "${var.environment}"
    "CustomerAlias" = "***"
    "Name"          = "prod-***-${var.secondary-region}-VPC"
  }
}