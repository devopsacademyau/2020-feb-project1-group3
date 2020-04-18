ECR_REPO ?= "160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/group3-wordpress"
TAG ?= latest
REPO_IMAGE ?= $(ECR_REPO):$(TAG)
IMAGE_NAME ?= "hello-world"

all: init plan apply aws build tag push

#Terraform

init: 
	terraform init

plan: init
	terraform plan -var-file terraform.tfvars -out=.terraform-plan

apply:  
	terraform apply .terraform-plan

#AWS

aws:  
	aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin $(ECR_REPO)
#Docker

build:   
	docker build -t $(IMAGE_NAME) .

tag: 
	docker tag $(IMAGE_NAME) $(REPO_IMAGE) 

push: tag aws
	docker push $(REPO_IMAGE)



