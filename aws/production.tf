resource "random_id" "random_id_prefix" {
    byte_length = 2  
}

locals {
  production_availability_zone = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source = "./networking"
  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zone   = "${local.production_availability_zone}"
}