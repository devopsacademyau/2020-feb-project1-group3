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


### Prerequisites
The ecr repository need to be created in you aws account before you push the image to the ecr.
Run below command to create a ecr repository if you don't have the repository created.
```
make  deploy_ecr
```
### How to Run
Run below to push wordpress image to ECR from the Dockerfile. You need to configure
the variable with your aws account id, region and your ecr repo name.
```
make prepare
```
Deploy the whole stack that running ec2 instances from the image that you pushed to the ecr
```
make deploy_aws
```




