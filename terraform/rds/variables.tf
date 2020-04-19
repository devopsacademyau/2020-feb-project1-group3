variable project_name {
    default = "devopsacademy-project"
    type = string
}

variable db_name {
    default = "db1"
    type = string
}
variable vpc_cidr {
    type = string
    default = "10.0.0.0/16"
}


variable db_sg_name {
    default = "devopsacademy-project-db-sg"
    type = string
}
variable cluster_name {
    default = "devopsacademy-project-cluster"
    type = string
}

variable db_subnet_group_name {
    type = string
}

variable availability_zones {
    type = list
    default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "vpc_id" {
    type = string
}

variable "db_user_name" {
    type = string
    default = "admin"
}

variable "db_password" {
    type = string
    default = "admin123"
}