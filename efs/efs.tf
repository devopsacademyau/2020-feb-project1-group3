# EFS File System

resource "aws_efs_file_system" "project_efs" {
  creation_token = "${var.project_name}-file-system"
  throughput_mode = "bursting"
  performance_mode = "generalPurpose"
  encrypted = true
}

# EFS Mount Target

resource "aws_efs_mount_target" "project_mount_target" {
  file_system_id = aws_efs_file_system.project_efs.id
  subnet_id      = var.private_subnet_id
  security_groups = [aws_security_group.project_security_group.id]
}

# Security Group

resource "aws_security_group" "project_security_group" {
  name        = var.sg_name
  description = "Security Group for Elastic File System"
  vpc_id      = var.vpc_id

ingress {
    description = "ECS Access"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = var.tag
  }
}