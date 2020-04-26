data "aws_iam_role" "ecs_role" {
  name = "ecsTaskExecutionRole"
}
data "aws_caller_identity" "account" {}
data "aws_region" "current" {}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "${var.project_name}-task-definition"
  execution_role_arn = data.aws_iam_role.ecs_role.arn

  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "wordpress-container",
      "image": "160372566358.dkr.ecr.ap-southeast-2.amazonaws.com/group3-wordpress:latest",
      "cpu": 10,
      "memory": 512,
      "essential": true,
      "secrets": [
        { 
          "name": "WORDPRESS_DB_HOST",
          "valueFrom": "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.account.account_id}:parameter/WORDPRESS_DB_HOST"
        },
        { 
          "name": "WORDPRESS_DB_USER",
          "valueFrom": "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.account.account_id}:parameter/WORDPRESS_DB_USER"
        }, 
        { 
          "name": "WORDPRESS_DB_PASSWORD",
          "valueFrom": "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.account.account_id}:parameter/WORDPRESS_DB_PASSWORD"
        }, 
        { 
          "name": "WORDPRESS_DB_NAME",
          "valueFrom": "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.account.account_id}:parameter/WORDPRESS_DB_NAME"
        }   
      ],
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "mountPoints": [
                {
                    "sourceVolume": "${var.volume_name}",
                    "containerPath": "${var.container_path}"
                }
      ]
    }
  ]
  TASK_DEFINITION

  volume {
    name      = var.volume_name
    host_path = var.host_path

  }
}
