file-system-id ?= "fs-4b170872" #change it before run make efs
client-token ?= "group3-file-system"
path ?= "/wordpress"
name ?= "wordpress"

all: init plan apply

#Terraform

init: 
	terraform init

plan: init
	terraform plan -var-file terraform.tfvars -out=.terraform-plan

apply:  
	terraform apply .terraform-plan

#AWS EFS Access Point

efs: 
	aws efs create-access-point --file-system-id $(file-system-id) --client-token $(client-token) \
	--root-directory Path=$(path) --tags Key="name",Value=$(name)