variable "primary_region" {
  description = "Primary AWS region"
  type        = string
}

variable "secondary_region" {
  description = "Secondary AWS region for DR"
  type        = string
}

variable "db_identifier" {
  type = string
}

variable "environment" {
  type = string
}
