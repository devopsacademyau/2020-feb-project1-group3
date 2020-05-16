prepare:
	./run.sh push-image

apply_aws:
	./run.sh apply-aws	

destroy_aws:
	./run.sh destroy-aws 	

deploy_ecr:
	./run.sh deploy-ecr

# .PHONY: deploy
# deploy: build
# 	aws ecs update-task-definition \
# 	--task-definition $(TASK_DEFINITIONS) \
# 	--revision $(REPO_IMAGE)
# 	aws ecs update-service \
# 	--cluster $(CLUSTER) \
# 	--service $(SERVCE)  \
# 	--force-new-deployment



	

