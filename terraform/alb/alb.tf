resource "aws_lb" "lb" {
  name               = "${var.projectname}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.sg.id]
  subnets            = data.aws_subnet_ids.subs.ids
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
  vpc_id   = data.aws_vpc.vpc.id
}
resource "aws_lb_target_group_attachment" "lbtga" {
  target_group_arn = aws_lb_target_group.lbtg.arn
  target_id        = data.aws_instance.inst.id
  port             = 80
}


data "aws_instance" "inst" {
  filter {
    name   = "image-id"
    values = [var.ami]
  }
}
data "aws_vpc" "vpc" {
    filter {
        name = "tag:Name"
        values = ["${var.projectname}*"]
    }
}
data "aws_subnet_ids" "subs" {
    vpc_id = data.aws_vpc.vpc.id
  filter {
        name = "tag:Name"
        values = ["${var.projectname}-public*"]
  }
}
data "aws_security_group" "sg" {
    vpc_id = data.aws_vpc.vpc.id
}