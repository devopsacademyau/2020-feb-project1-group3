resource "aws_ecs_cluster" "ecscluster" {
  name = "clusterinho"
}



# resource "aws_launch_template" "grp3-lt" {
#   name_prefix   = "pr1-grp3-lt"
#   image_id      = "ami-0970010f37c4f9c8d"
#   instance_type = "t2.micro"
#   key_name      = "bastion"
# }

resource "aws_launch_configuration" "grp3-lc" {
  name = "pr1-grp3-lc"
  image_id = "ami-064db566f79006111"
  instance_type = "t2.micro"
  key_name      = "bastion"
}

resource "aws_autoscaling_group" "grp3-asg" {
  availability_zones = ["ap-southeast-2a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_configuration = aws_launch_configuration.grp3-lc.name
  # launch_template {
  #   id      = aws_launch_template.grp3-lt.id
  #   version = "$Latest"
  # }
}






# resource "aws_ecs_task_definition" "service" {
#     family                = "service"
#     container_definitions = file("tdservice.json")
# #   volume {
# #     name = "service-storage"
# #     efs_volume_configuration {
# #       file_system_id = aws_efs_file_system.fs.id
# #       root_directory = "/var/www/hmtl"
# #     }
# #   }    
# }

# resource "aws_ecs_service" "hlwrd" {
#   name            = "hlwrd"
#   cluster         = aws_ecs_cluster.ecscluster.id
#   task_definition = aws_ecs_task_definition.service.arn
#   desired_count   = 1
# #   iam_role        = aws_iam_role.ecsrun.arn
# #   depends_on      = [aws_iam_role_policy.polecsrun]

# #   ordered_placement_strategy {
# #     type  = "binpack"
# #     field = "cpu"
# #   }
#   # load_balancer {
#   #   target_group_arn = aws_lb_target_group.albtg.arn
#   #   container_name   = "helloworld"
#   #   container_port   = 80
#   # }
# #   placement_constraints {
# #     type       = "memberOf"
# #     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
# #   }