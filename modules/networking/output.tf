output "company-private-subnets" {
  value = aws_subnet.company-private[*].id
}

output "company-public-subnets" {
  value = aws_subnet.company-public[*].id
}

output "vpc" {
  value = aws_vpc.company_vpc.id
}