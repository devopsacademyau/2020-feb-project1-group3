SHELL := /bin/bash
.SILENT:

ECR_REPO ?= "607961847144.dkr.ecr.ap-southeast-2.amazonaws.com/darepo"
REPO_IMAGE ?= $(ECR_REPO):$(TAG)
IMAGE_NAME ?= "hello-world"
TAG ?= ""
TASK_DEFINITIONS ?= 

VARIABLES_FILE? = main.tfvars
REGION ?= ap-southeast-2
CLUSTER ?=
SERVICE ?=


#docker compose calls:
GIT = docker-compose run --rm git
TERRAFORM = docker-compose run --rm terraform

.PHONY: _auth
_auth:
	aws ecr get-login-password \
	--region $(REGION) \
	--| docker login --username AWS \
	--password-stdin $(ECR_REPO)


.PHONY: _tag
_tag:
	docker build -t $(IMAGE_NAME) .
	$(eval TAG=$(shell git rev-parse --short HEAD))
	$(eval REPO_IMAGE = $(ECR_REPO):$(TAG))
	docker tag $(IMAGE_NAME) $(REPO_IMAGE) 

.PHONY: build
build: _auth _tag
	docker push $(REPO_IMAGE)

.PHONY: deploy
deploy: build
	aws ecs update-task-definition \
	--task-definition $(TASK_DEFINITIONS) \
	--revision $(REPO_IMAGE)
	aws ecs update-service \
	--cluster $(CLUSTER) \
	--service $(SERVCE)  \
	--force-new-deployment

.PHONY: deploy_infra 
deploy_infra: _prepare _init _plan _apply
	
.PHONY: _apply
_apply:
	$(TERRAFORM) apply ./terraform/terraform-plan

.PHONY: _plan
_plan: _prepare
	$(TERRAFORM) plan -var-file ./terraform/main.tfvars -out=./terraform/terraform-plan ./terraform

.PHONY:_init
_init:
	$(TERRAFORM) init ./terraform

.PHONY: _prepare
_prepare:
	docker-compose pull git
	docker-compose pull terraform

.PHONY: _destroy
_destroy:
	$(TERRAFORM) destroy  -var-file ./terraform/main.tfvars ./terraform

