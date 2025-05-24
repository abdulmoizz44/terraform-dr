resource "aws_backup_plan" "ec2-daily" {
  name = "company-instances-backup-daily-${var.dr-region}"

  rule {
    rule_name                    = "company-instances-backup-daily-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 * * ? *)" # 12:30 AM daily UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 7
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "ec2" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-ec2-instances"
  plan_id      = aws_backup_plan.ec2-daily.id

  resources = [
    var.backend-instance-arn,
    var.webapp-instance-arn,
    var.company-staging-arn,
    var.company-prod-arn
  ]
}

#-----------------------------------------

resource "aws_backup_plan" "rds-daily" {
  name = "company-rds-backup-daily-${var.dr-region}"

  rule {
    rule_name                    = "company-rds-backup-daily-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 * * ? *)" # 12:30 AM daily UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 7
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "rds" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-rds-instances"
  plan_id      = aws_backup_plan.rds-daily.id

  resources = [
    var.company-rds-arn
  ]
}

#------------------------------

resource "aws_backup_plan" "ec2-weekly" {
  name = "company-instances-backup-weekly-${var.dr-region}"

  rule {
    rule_name                    = "company-instances-backup-weekly-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 ? * SUN *)" # 12:30 AM weekly on sunday UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 28
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "ec2-weekly" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-rds-instances"
  plan_id      = aws_backup_plan.ec2-weekly.id

  resources = [
    var.backend-instance-arn,
    var.webapp-instance-arn,
    var.company-staging-arn,
    var.company-prod-arn
  ]
}

#------------------------

resource "aws_backup_plan" "rds-weekly" {
  name = "company-rds-backup-weekly-${var.dr-region}"

  rule {
    rule_name                    = "company-rds-backup-weekly-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 ? * SUN *)" # 12:30 AM weekly on sunday UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 28
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "rds-weekly" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-rds-instances"
  plan_id      = aws_backup_plan.rds-weekly.id

  resources = [
    var.company-rds-arn
  ]
}

#---------------------------

resource "aws_backup_plan" "ec2-monthly" {
  name = "company-instances-backup-monthly-${var.dr-region}"

  rule {
    rule_name                    = "company-instances-backup-monthly-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 1 * ? *)" # 12:30 AM monthly on 1st UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 365
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "ec2-monthly" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-ec2-instances"
  plan_id      = aws_backup_plan.ec2-monthly.id

  resources = [
    var.backend-instance-arn,
    var.webapp-instance-arn,
    var.company-staging-arn,
    var.company-prod-arn
  ]
}

#-----------------------

resource "aws_backup_plan" "rds-monthly" {
  name = "company-rds-backup-monthly-${var.dr-region}"

  rule {
    rule_name                    = "company-rds-backup-monthly-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(30 0 1 * ? *)" # 12:30 AM monthly on 1st UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 365
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "rds-monthly" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-rds-instances"
  plan_id      = aws_backup_plan.rds-monthly.id

  resources = [
    var.company-rds-arn
  ]
}

#----------------------

resource "aws_backup_plan" "ec2-anually" {
  name = "company-instances-backup-anually-${var.dr-region}"

  rule {
    rule_name                    = "company-instances-backup-anually-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(0 0 1 1 ? *)" # 12:00 AM anually on 1st UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 2555
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "ec2-anually" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-ec2-instances"
  plan_id      = aws_backup_plan.ec2-anually.id

  resources = [
    var.backend-instance-arn,
    var.webapp-instance-arn,
    var.company-staging-arn,
    var.company-prod-arn
  ]
}

#------------------

resource "aws_backup_plan" "rds-anually" {
  name = "company-rds-backup-anually-${var.dr-region}"

  rule {
    rule_name                    = "company-rds-backup-anually-rule"
    target_vault_name            = aws_backup_vault.company-vault.name
    schedule                     = "cron(0 0 1 1 ? *)" # 12:30 AM anually on 1st UTC
    schedule_expression_timezone = "America/Phoenix"
    start_window                 = 60
    completion_window            = 120
    enable_continuous_backup     = false

    lifecycle {
      delete_after = 2555
    }

    copy_action {
      destination_vault_arn = var.dr-vault
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "disabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "rds-anually" {
  iam_role_arn = "arn:aws:iam::***:role/service-role/AWSBackupDefaultServiceRole"
  name         = "company-rds-instances"
  plan_id      = aws_backup_plan.rds-anually.id

  resources = [
    var.company-rds-arn
  ]
}