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


