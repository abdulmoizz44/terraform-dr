output "web-prod-backend-ami" {
  value = aws_ami_from_instance.web-prod-backend.id
}

output "web-prod-webapp-ami" {
  value = aws_ami_from_instance.web-prod-webapp.id
}

output "web-staging-company-ami" {
  value = aws_ami_from_instance.web-staging-company.id
}

output "web-prod-company-ami" {
  value = aws_ami_from_instance.web-prod-company.id
}

output "company-cluster-arn" {
  value = data.aws_db_instance.testing-one.db_instance_arn
}

output "web-prod-backend-arn" {
  value = data.aws_instance.web-prod-backend.arn
}

output "web-prod-webapp-arn" {
  value = data.aws_instance.web-prod-webapp.arn
}

output "web-staging-company-arn" {
  value = data.aws_instance.web-staging-company.arn
}

output "web-prod-company-arn" {
  value = data.aws_instance.web-prod-company.arn
}

output "s3_bucket_id" {
  value = data.aws_s3_bucket.name.id
}

output "secret_string" {
  value = data.aws_secretsmanager_secret_version.secret-version.secret_string
}