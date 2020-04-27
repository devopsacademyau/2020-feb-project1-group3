=======
DevOps Academy - Project 1 - Group 3
==================

EFS - Access Point
------------

Terraform code for access point to be deployed.
[See more](http://github.com/terraform-providers/terraform-provider-aws/issues/12118) 
- Meanwhile usig AWS cli to c reate the efs access point.
See [Makefile](efs/Makefile) 


# Terraform files

# Network
[vpc.tf](terraform/network/vpc.tf)
[variables.tf](terraform/network/variables.tf)
[terraform.tfvars](terraform/network/terraform.tfvars)

# ECS
[ecs.tf](terraform/ecs/ecs.tf)
[iam.tf](terraform/ecs/iam.tf)
[terraform.tfvars](terraform/ecs/terraform.tfvars)
[userdata.tpl](terraform/ecs/userdata.tpl)
[variables.tf](terraform/ecs/variables.tf)

# ALB
[alb.tf](terraform/alb/alb.tf)
[terraform.tfvars](terraform/alb/terraform.tfvars)
[variables.tf](terraform/alb/variables.tf)
