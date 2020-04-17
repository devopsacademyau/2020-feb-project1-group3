all: init plan apply aws build tag push

#Terraform

init: 
	terraform init

plan: init
	terraform plan 

apply: plan 
	terraform apply -auto-approve

#AWS

aws: apply 
	aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/project_ecr

#Docker

build: aws  
	docker build -t hello-world .

tag: build
	docker tag hello-world 160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/project_ecr:latest

push: tag
	docker push 160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/project_ecr:latest



