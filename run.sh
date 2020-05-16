#!/usr/bin/env bash
set -ueo pipefail

# Target aws environment variables
FUNC="${1:-}"
AWS_REGION="${AWS_REGION:-ap-southeast-2}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:-607961847144}"
ECR_REPO="${ECR_REPO:-wordpress}"

# Docker compose calls
TERRAFORM="docker-compose run --rm terraform"

push-image() {
    ecr_registry="${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_REGION}".amazonaws.com
    sha=$(git rev-parse --short HEAD)
    aws ecr get-login-password \
    --region "${AWS_REGION}" | docker login \
    --username AWS --password-stdin $ecr_registry
    docker build -t $ecr_registry/"${ECR_REPO}":$sha .
    docker push $ecr_registry/"${ECR_REPO}":$sha
}

apply-aws() {
    docker-compose pull terraform
    ${TERRAFORM} init ./terraform
    ${TERRAFORM} plan -var-file ./terraform/main.tfvars -out=./terraform/terraform-plan ./terraform
    ${TERRAFORM} apply ./terraform/terraform-plan
}

destroy-aws() {
    docker-compose pull terraform
    ${TERRAFORM} destroy  -var-file ./terraform/main.tfvars ./terraform
}

deploy-ecr() {
    docker-compose pull terraform
    ${TERRAFORM} init ./terraform/
    ${TERRAFORM} plan -var-file ./terraform/main.tfvars  -out=./terraform/ecr.plan ./terraform/ecr 
    ${TERRAFORM} apply ./terraform/ecr.plan  
}

case "${FUNC:-}" in
push-image)
    push-image
    ;;
apply-aws)
    apply-aws
    ;;
destroy-aws)
    destroy-aws
    ;;    
deploy-ecr)
    deploy-ecr
    ;;         
esac

