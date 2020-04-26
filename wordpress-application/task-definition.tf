data "aws_iam_role" "ecs_role" {
  name = "ecsTaskExecutionRole"
}

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
          "valueFrom": "arn:aws:ssm:ap-southeast-2:160372566358:parameter/WORDPRESS_DB_HOST"
        }
        { 
          "name": "WORDPRESS_DB_USER",
          "valueFrom": "arn:aws:ssm:ap-southeast-2:160372566358:parameter/WORDPRESS_DB_USER"
        }  
        { 
          "name": "WORDPRESS_DB_PASSWORD",
          "valueFrom": "arn:aws:ssm:ap-southeast-2:160372566358:parameter/WORDPRESS_DB_PASSWORD"
        }  
        { 
          "name": "WORDPRESS_DB_NAME",
          "valueFrom": "arn:aws:ssm:ap-southeast-2:160372566358:parameter/WORDPRESS_DB_NAME"
        }       
      ],

      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  TASK_DEFINITION

  volume {
    name = "service-storage"
    efs_volume_configuration {
      file_system_id = var.file_system_id
      root_directory = "/var/www/html"
    }
  }
}
