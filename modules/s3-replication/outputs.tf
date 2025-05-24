output "replication_bucket_arn" {
  value = aws_s3_bucket.dr-bucket.arn
}

output "s3_bucket_versioning" {
  value = aws_s3_bucket_versioning.destination
}