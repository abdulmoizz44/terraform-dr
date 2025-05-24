data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

resource "aws_db_instance" "dr-read-replica" {
  depends_on              = [var.company-cluster-arn]
  identifier              = var.db_identifier
  instance_class          = "db.t3.small"
  storage_type            = "gp3"
  engine_version          = "15.7"
  kms_key_id              = data.aws_kms_key.rds.arn
  db_subnet_group_name    = aws_db_subnet_group.read-replica.name
  vpc_security_group_ids  = [var.rds-sg]
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
  tags = {
    Name = "read-replia-dr"
  }

  #Replication for DR
  replicate_source_db = var.company-cluster-arn
}

resource "aws_db_subnet_group" "read-replica" {
  name       = "main"
  subnet_ids = var.company-private-subnets

  tags = {
    Name = "My DB subnet group"
  }
}