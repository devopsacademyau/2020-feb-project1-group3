resource "aws_lb" "lb" {
    name               = "${var.projectname}-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb-sg.id]
    subnets            = [var.pub_sub1, var.pub_sub2]
    tags = {
        Name = "${var.projectname}-lb"
  }
}


resource "aws_security_group" "alb-sg" {
    name   = "alb-sg"
    vpc_id = var.vpc_id

    lifecycle {
        create_before_destroy = true
    }
    ingress {

        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
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
  vpc_id   = var.vpc_id
}

output "alb_sg" {
    value = aws_security_group.alb-sg.id
}


output "target_group_arn" {
    value = aws_lb_target_group.lbtg.arn
}
# resource "aws_lb_target_group_attachment" "lbtga" {
#   target_group_arn = aws_lb_target_group.lbtg.arn
#   target_id        = data.aws_instance.inst.id
#   port             = 80
# }


# data "aws_instance" "inst" {
#   filter {
#     name   = "image-id"
#     values = [var.ami]
#   }
# }
# data "aws_vpc" "vpc" {
#     filter {
#         name = "tag:Name"
#         values = ["${var.projectname}*"]
#     }
# }  

# data "aws_subnet_ids" "subs" {
#         vpc_id = data.aws_vpc.vpc.id
#   filter {
#         name = "tag:Name"
#         values = ["${var.projectname}-public*"]
#   }
# }

# data "aws_security_group" "sg" {
#     vpc_id = data.aws_vpc.vpc.id
# }