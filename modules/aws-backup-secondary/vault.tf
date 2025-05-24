resource "aws_backup_vault" "company-dr" {
  name          = "company-dr-vault-${var.dr-region}"
  force_destroy = "true"
}