variable "vpc_id" {
}

variable "company-private-subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

#----
variable "web-prod-backend-ami" {
}

variable "web-prod-webapp-ami" {
}

variable "web-staging-company-ami" {
}

variable "web-prod-company-ami" {
}

variable "backend-tg-arn" {
}

variable "webapp-tg-arn" {
}

variable "dr-region" {
}

variable "rds-readreplica-endpoint" {
}

variable "webapp-lb-dns-name" {
}

variable "backend-lb-dns-name" {
}