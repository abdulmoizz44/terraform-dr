resource "aws_backup_vault" "company-vault" {
  name          = "company-backup-vault-dr"
  force_destroy = "true"
}
