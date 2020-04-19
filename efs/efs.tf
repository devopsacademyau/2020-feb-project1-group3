# EFS File System

resource "aws_efs_file_system" "project_efs" {
  creation_token = "${var.project_name}-file-system"
  throughput_mode = "bursting"
  performance_mode = "generalPurpose"
  encrypted = false
}

# EFS Moutn Target

resource "aws_efs_mount_target" "project_mount_target" {
  file_system_id = aws_efs_file_system.project_efs.id
  subnet_id      = var.private_subnet_id
  security_groups = [var.security_groups[0].id]
}