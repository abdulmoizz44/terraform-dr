# Fetch the availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Local variable to store the number of available AZs
locals {
  available_az_count = length(data.aws_availability_zones.available.names)
}

# Ensure there are at least 2 availability zones
resource "null_resource" "check_az_count" {
  count = local.available_az_count >= 2 ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'Error: At least 2 Availability Zones are required, but only ${local.available_az_count} are available in region ${var.secondary-region}'"
  }

  triggers = {
    az_check = local.available_az_count
  }
}

# Create public subnets dynamically based on the number of AZs
resource "aws_subnet" "company-public" {
  count                   = local.available_az_count
  vpc_id                  = aws_vpc.company_vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "CustomerAlias" = "***"
    "Environment"   = var.environment
    "IaC"           = "true"
    "Name"          = "***-${var.secondary-region}-PUB-SUBNET-AZ-${count.index + 1}"
    "Reach"         = "public"
  }
}

# Create private subnets dynamically based on the number of AZs
resource "aws_subnet" "company-private" {
  count                   = local.available_az_count
  vpc_id                  = aws_vpc.company_vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + local.available_az_count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    "CustomerAlias" = "***"
    "Environment"   = var.environment
    "IaC"           = "true"
    "Name"          = "***-${var.secondary-region}-PRIV-SUBNET-AZ-${count.index + 1}"
    "Reach"         = "private"
  }
}