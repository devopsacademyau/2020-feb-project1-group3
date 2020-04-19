This doc contains informations about terraform code

# How to run

To run the code, use "terraform plan" to check what will happen and then "terraform apply"


# File [VPC.tf](vpc.tf)

This file contains all the code required to create the following resources:

-vpc
-subnets
-internet_gateway
-route_tables
-network_acls


# File [Variables.tf](variables.tf)

This file contains all declared variables required to create resources on other tf files


# File [Terraform.tfvars](terraform.tfvars)

This file contains the content of variables declared on variables.tf file.