resource "aws_internet_gateway" "company-IG" {
  vpc_id = aws_vpc.company_vpc.id
  tags = {
    "Environment"   = "${var.environment}"
    "IaC"           = "true"
    "Name"          = "${var.secondary-region}-IG-dr"
  }
}