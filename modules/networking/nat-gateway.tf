resource "aws_nat_gateway" "company-NG" {
  allocation_id = aws_eip.company-eip.id
  subnet_id     = aws_subnet.company-public[0].id # Use the first public subnet
  tags = {
    "Environment"   = var.environment
    "IaC"           = "true"
    "Name"          = "${var.secondary-region}-NAT-dr"
  }

  depends_on = [aws_internet_gateway.company-IG]
}