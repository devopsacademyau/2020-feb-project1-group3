variable "projectname" {type = string}
variable "az" {type = list}
variable "inst_type" {type = string}
variable "inst_key" {type = string}
variable "ami_id" {type=string}
variable "asg_desired_capac"  {type=string}
variable "asg_max_size"  {type=string}
variable "asg_min_size"  {type=string}