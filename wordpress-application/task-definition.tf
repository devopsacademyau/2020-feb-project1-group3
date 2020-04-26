resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                = "${var.project_name}-task-definition"
  container_definitions = file("./service.json")

    volume {
      name      = "service-storage"
      efs_volume_configuration {
        file_system_id = var.file_system_id
        root_directory = "/var/www/html"
    }
  }
}