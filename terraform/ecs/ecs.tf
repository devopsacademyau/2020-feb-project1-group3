resource "aws_ecs_cluster" "ecscluster" {
  name = "clusterinho"
}

resource "aws_ecs_task_definition" "service" {
    family                = "service"
    container_definitions = file("tdservice.json")
#   volume {
#     name = "service-storage"
#     efs_volume_configuration {
#       file_system_id = aws_efs_file_system.fs.id
#       root_directory = "/var/www/hmtl"
#     }
#   }    
}

resource "aws_ecs_service" "hlwrd" {
  name            = "hlwrd"
  cluster         = aws_ecs_cluster.ecscluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
#   iam_role        = aws_iam_role.ecsrun.arn
#   depends_on      = [aws_iam_role_policy.polecsrun]

#   ordered_placement_strategy {
#     type  = "binpack"
#     field = "cpu"
#   }
  load_balancer {
    target_group_arn = aws_lb_target_group.albtg.arn
    container_name   = "helloworld"
    container_port   = 80
  }
#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }

}

resource "aws_lb" "albhlwrd" {
  name               = "alb-grp3"
  internal           = false
  load_balancer_type = "application"
#   security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["subnet-0892252d3182bc1b0","subnet-0bc673e500533502b"]   
  #[aws_subnet.public-subs[*].id]
#   access_logs {
#     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
#     prefix  = "test-lb"
#     enabled = true
#   }
}

resource "aws_lb_target_group" "albtg" {
  name     = "pr1-grp3-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-04d0e947c4335058a"
}

resource "aws_lb_target_group_attachment" "albtggroup" {
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.devopsec2.id
  port             = 80
}

resource "aws_instance" "devopsec2" {
  ami           = "ami-08fdde86b93accf1c"
  instance_type = "t2.micro"
#   iam_instance_profile = aws_iam_instance_profile.instprof.name
#   security_groups = [aws_security_group.allow_ssh.name]
  key_name = "bastion"
}