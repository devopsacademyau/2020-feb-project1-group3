push_image:
	./run.sh push-image

refresh_image:
	./run.sh refresh-image

apply_aws:
	./run.sh apply-aws	

destroy_aws:
	./run.sh destroy-aws 	

prep_ecr:
	./run.sh prep-ecr

# .PHONY: deploy
# deploy: build
# 	aws ecs update-task-definition \
# 	--task-definition $(TASK_DEFINITIONS) \
# 	--revision $(REPO_IMAGE)
# 	aws ecs update-service \
# 	--cluster $(CLUSTER) \
# 	--service $(SERVCE)  \
# 	--force-new-deployment



	

