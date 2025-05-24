terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  alias  = "primary"
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

module "compute" {
  source                     = "./modules/compute"
  providers                  = { aws = aws.secondary }
  vpc_id                     = module.networking.vpc
  company-private-subnets = module.networking.company-private-subnets # Pass dynamically created private subnets

  depends_on               = [module.primary]
  web-prod-backend-ami     = module.primary.web-prod-backend-ami
  web-prod-webapp-ami      = module.primary.web-prod-webapp-ami
  web-staging-company-ami    = module.primary.web-staging-company-ami
  web-prod-company-ami       = module.primary.web-prod-company-ami
  dr-region                = var.secondary_region
  webapp-tg-arn            = module.alb.webapp-tg-arn
  backend-tg-arn           = module.alb.backend-tg-arn
  rds-readreplica-endpoint = module.database.rds-readreplica-endpoint
  webapp-lb-dns-name       = module.alb.webapp-lb-dns-name
  backend-lb-dns-name      = module.alb.backend-lb-dns-name
}

module "database" {
  source                     = "./modules/database"
  providers                  = { aws = aws.secondary }
  depends_on                 = [module.primary]
  company-private-subnets = module.networking.company-private-subnets # Use the list of private subnets
  db_identifier              = var.db_identifier
  rds-sg                     = module.compute.rds_sg
  company-cluster-arn     = module.primary.company-cluster-arn
}

module "networking" {
  source           = "./modules/networking"
  providers        = { aws = aws.secondary }
  secondary-region = var.secondary_region
  environment      = var.environment
}

module "primary" {
  source               = "./modules/primary"
  providers            = { aws = aws.primary }
  s3_bucket_arn        = module.bucket.replication_bucket_arn
  s3_bucket_versioning = module.bucket.s3_bucket_versioning
}

module "alb" {
  source                    = "./modules/alb"
  providers                 = { aws = aws.secondary }
  vpc                       = module.networking.vpc
  company-public-subnets = module.networking.company-public-subnets
  depends_on                = [module.networking]
}

module "backup" {
  source               = "./modules/aws-backup"
  providers            = { aws = aws.primary }
  backend-instance-arn = module.primary.web-prod-backend-arn
  webapp-instance-arn  = module.primary.web-prod-webapp-arn
  company-staging-arn    = module.primary.web-staging-company-arn
  company-prod-arn       = module.primary.web-prod-company-arn
  dr-vault             = module.backup-secondary.dr-vault
  company-rds-arn   = module.primary.company-cluster-arn
  dr-region            = var.secondary_region
}

module "backup-secondary" {
  source    = "./modules/aws-backup-secondary"
  providers = { aws = aws.secondary }
  dr-region = var.secondary_region
}

module "bucket" {
  source    = "./modules/s3-replication"
  providers = { aws = aws.secondary }
}

module "secrets_manager" {
  source        = "./modules/secrets-manager-replication"
  providers     = { aws = aws.secondary }
  secret_string = module.primary.secret_string
}

module "route53" {
  source              = "./modules/route53"
  providers           = { aws = aws.primary }
  webapp-lb-dns-name  = module.alb.webapp-lb-dns-name
  webapp-lb-zone-id   = module.alb.webapp-lb-zone-id
  backend-lb-dns-name = module.alb.backend-lb-dns-name
  backend-lb-zone-id  = module.alb.backend-lb-zone-id
}