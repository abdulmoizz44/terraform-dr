resource "aws_eip" "company-eip" {

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = "${var.environment}"
    "IaC"           = "true"
    "Name"          = "***-${var.secondary-region}-EIP-dr"
  }
}