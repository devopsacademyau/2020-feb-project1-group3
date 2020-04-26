resource "aws_lb" "lb" {
  name               = "${var.projectname}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-ec2-sg.id]
  subnets            = aws_subnet.public-subs.ids
  tags = {
    Name = "${var.projectname}-lb"
  }
}
resource "aws_lb_listener" "lblistener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lbtg.arn
  }
}
resource "aws_lb_target_group" "lbtg" {
  name     = "${var.projectname}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
resource "aws_lb_target_group_attachment" "lbtga" {
  target_group_arn = aws_lb_target_group.lbtg.arn
  target_id        = aws_ecs_service.project_ecs_service.id
  port             = 80
}