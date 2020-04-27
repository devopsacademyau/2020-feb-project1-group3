resource "aws_ecs_cluster" "ecscluster" {
  name = "${var.projectname}-cluster"
}

resource "aws_launch_configuration" "lc" {
  name = "${var.projectname}-lc"
  image_id = var.ami_id
  instance_type = var.inst_type
  key_name      = var.inst_key != "" ? var.inst_key : ""
  user_data = base64encode(data.template_file.userdata.rendered)
  iam_instance_profile = aws_iam_instance_profile.instprof.name
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = var.az
  desired_capacity   = var.asg_desired_capac
  max_size           = var.asg_max_size
  min_size           = var.asg_min_size
  launch_configuration = aws_launch_configuration.lc.name
}
data "template_file" "userdata" {
  template = file("userdata.tpl")
  vars = {
    ecs_cluster_name = aws_ecs_cluster.ecscluster.name
    efs_id = aws_efs_file_system.efs.id
  }
}
resource "aws_efs_file_system" "efs" {
  tags = {
    Name = "${var.projectname}-efs"
  }
}
