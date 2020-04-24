SHELL := /bin/bash
.SILENT:

ECR_REPO ?= "160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/group3-wordpress"
TAG ?= latest
REPO_IMAGE ?= $(ECR_REPO):$(TAG)
IMAGE_NAME ?= "hello-world"

VARIABLES_FILE? = main.tfvars



.PHONE: build
build: build docker image and push to ecr
	docker build -t $(IMAGE_NAME) .
	docker tag $(IMAGE_NAME) $(REPO_IMAGE) 
	docker push $(REPO_IMAGE)

.PHONY : deploy 
deploy:
	terraform_apply

.PHONY : terraform_init
terraform_init:
	terraform init

.PHONY: terrafrom_plan
terrafrom_plan: terraform_init
	terraform plan --var-file ${VARIABLES_FILE}

.PHONY: terraform_apply  
terraform_apply: terraform_init terrafrom_plan
	terraform apply --var-file ${VARIABLES_FILE} -out=.terraform-plan
