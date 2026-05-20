terraform {
    required_version = ">=1.15.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.0"
        }
    }
}

provider "aws" {
    region      = var.aws_region
    access_key  = var.aws_Access_Key
    secret_key  = var.aws_Secret_Key
    # key_name    = var.key_pair_name
}

module "vpc" {
  source = "./modules/vpc"

}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "bastion" {
  source = "./modules/bastion"
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.security_groups.bastion_sg_id
  key_pair_name = var.key_pair_name
}

module "backend" {
  source = "./modules/backend"
  subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_groups.backend_sg_id
  key_pair_name = var.key_pair_name
}

module "database" {
  source = "./modules/database"
  subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_groups.database_sg_id
  key_pair_name = var.key_pair_name
}