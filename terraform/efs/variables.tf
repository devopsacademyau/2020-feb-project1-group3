variable "project_name" {
  type = "string"
}

variable "tag" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "private_subnet_id" {
  type = "string"
}

variable "ecs_nodes_sg_id" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
}

variable "security_group" {
  type = list(any)
}


