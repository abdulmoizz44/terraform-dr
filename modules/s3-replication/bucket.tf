resource "random_id" "bucket_suffix" {
  byte_length = 4 # Generates an 8-character long random ID
}


resource "aws_s3_bucket" "dr-bucket" {
  bucket = "company-dr-replication-bucket-${random_id.bucket_suffix.hex}" # Append the random suffix

  force_destroy = true

  tags = {
    Name        = "company-replication-bucket"
    Environment = "dr"
  }
}

resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.dr-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
