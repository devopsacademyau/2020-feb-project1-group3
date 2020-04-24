
module "network" {
  source  = "./network"
  public_subnets = var.public_subnets
  region = var.region
  private_subnets = var.private_subnets
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones

}

module "ecr" {
  source = "./ecr"
}

module "efs" {
  source = "./efs"
}

module "ecs" {
  source = "./ecs"
}


module "rds" {
  source  = "./rds"
  vpc_id = module.network.aws_vpc_id
  db_subnet_group_name = module.vpc.subnet_group_name
}