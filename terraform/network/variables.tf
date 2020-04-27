#Anderson variables:

variable "projectname" {type = string}
variable "region" {type = string}
variable "vpccidr" {type = string}
variable "publicsubnets" { 
    type = list(object({
        name = string
        cidr = string
        az = string
        publicip = bool
    }))
}
variable "privatesubnets" { 
    type = list(object({
        name = string
        cidr = string
        az = string
        publicip = bool
    }))
}



#Heaven variables: