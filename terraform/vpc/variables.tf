
variable "region" {
    default = "ap-southeast-2"
}

variable "public_subnets" { type = list(map(any))}
variable "private_subnets" { type = list(map(any))}

variable "vpc_cidr" { type = string }


variable "availability_zones" {
    type = list
}