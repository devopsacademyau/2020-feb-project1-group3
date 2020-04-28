DevOps Academy - Project 1 - Group 3
==================

# Application Migration: from On-Premise to The Cloud

The objective of this project is to migrate a single server and deployments from a FTP to AWS services.
- We have used [Terraform](https://www.terraform.io/) to create to create the resources in AWS.
- [Makefile](Makefile) to automate the scripts.
- [Docker](Dockerfile) to create the Wordpress image.


<b>Team:</b>
- Anderson
- Carine
- Heaven

## Architecture Diagram
Diagram of the proposed AWS Architecture:

![Diagram](images/PR1-grp3(5).png)

## AWS RESOURCES: 

### ALB - Application Load Balancer
- [alb.tf](terraform/alb/alb.tf)
- [terraform.tfvars](terraform/alb/terraform.tfvars)
- [variables.tf](terraform/alb/variables.tf)

### ECR - Elastic Container Registry 
- [ecr.tf](terraform/ecr/ecr.tf)
- [variables.tf](terraform/ecr/variables.tf)


### ECS - Elastic Container Service
Cluster EC2 | ASG (Auto Scaling Group | Task Description | Service 
- [ecs.tf](terraform/ecs/ecs.tf)
- [iam.tf](terraform/ecs/iam.tf)
- [terraform.tfvars](terraform/ecs/terraform.tfvars)
- [userdata.tpl](terraform/ecs/userdata.tpl)
- [variables.tf](terraform/ecs/variables.tf)


### EFS - Elastic File System
- [efs.tf](terraform/efs/efs.tf)
- [variables.tf](terraform/efs/variables.tf)

Terraform code for access point to be deployed. See more details [here](http://github.com/terraform-providers/terraform-provider-aws/issues/12118).
Meanwhile usig AWS cli to create the efs access point. [Makefile](efs/Makefile) created to run the AWS cli script.

### Network
VPC | Subnets | Gateways | ACLS | Route Tables 
- [vpc.tf](terraform/network/vpc.tf)
- [variables.tf](terraform/network/variables.tf)
- [output.tf](terraform/network/output.tf)

### RDS - Relational Datavase Service 
- [rds.tf](terraform/rds/rds.tf)
- [variables.tf](terraform/rds/variables.tf)
- [README.md](terraform/rds/README.md)

## How to Run
- Guide to run the VPC and Variables. 
  - [README.md](terraform/README.md)
- Guide to Docker Compose
  - [README.md](example/README.md)
- Guide to Wordpress
  - [README.md](wordpress/README.md)
