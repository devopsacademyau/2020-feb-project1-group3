variable "project_name" {
  type = "string"
}

variable "tag" {
  type = "string"
}

variable "availability_zone" {
  type = "string"
}

variable "private_subnet_id" {
  type = "string"
}

variable "security_groups" {
  type = list(any)
}


