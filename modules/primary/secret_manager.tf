data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:us-east-1:***:secret:Encryption_Secret-FZ4f8Y"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}