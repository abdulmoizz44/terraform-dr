data "aws_s3_bucket" "name" {
  bucket = "code-yellow-prod"
}

resource "aws_s3_bucket_replication_configuration" "replication" {

  depends_on = [var.s3_bucket_versioning]

  role   = "arn:aws:iam::***:role/service-role/**"
  bucket = data.aws_s3_bucket.name.id

  rule {
    id = "replica-rule"

    status = "Enabled"

    destination {
      bucket        = var.s3_bucket_arn
      storage_class = "STANDARD"
    }
  }
}