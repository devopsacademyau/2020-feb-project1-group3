resource "aws_ecs_service" "project_ecs_service" {
  name            = "${var.project_name}-ecs-service"
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1

#  load_balancer {
#    target_group_arn = "var.target_group_arn"
#    container_name   = "var.container_name"
#    container_port   = 8080
#  }
}