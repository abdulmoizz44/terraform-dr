output "rds-readreplica-endpoint" {
  value = aws_db_instance.dr-read-replica.address
}