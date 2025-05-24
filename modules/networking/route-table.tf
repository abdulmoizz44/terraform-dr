# PUBLIC ROUTE TABLE
resource "aws_route_table" "company-public-routetable" {
  vpc_id = aws_vpc.company_vpc.id

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = var.environment
    "IaC"           = "true"
    "Name"          = "prod-***-${var.secondary-region}-PUBLIC-RT"
  }
}

resource "aws_route" "public-internet-gateway" {
  route_table_id         = aws_route_table.company-public-routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.company-IG.id
}

resource "aws_route_table_association" "public" {
  count          = local.available_az_count
  subnet_id      = aws_subnet.company-public[count.index].id
  route_table_id = aws_route_table.company-public-routetable.id
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "company-private-routetable" {
  vpc_id = aws_vpc.company_vpc.id

  tags = {
    "CustomerAlias" = "***"
    "Environment"   = var.environment
    "IaC"           = "true"
    "Name"          = "prod-***-${var.secondary-region}-PRIVATE-RT"
  }
}

resource "aws_route" "private-nat-gateway" {
  route_table_id         = aws_route_table.company-private-routetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.company-NG.id
}

resource "aws_route_table_association" "private" {
  count          = local.available_az_count
  subnet_id      = aws_subnet.company-private[count.index].id
  route_table_id = aws_route_table.company-private-routetable.id
}