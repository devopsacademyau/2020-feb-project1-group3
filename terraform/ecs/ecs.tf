resource "aws_ecs_cluster" "ecscluster" {
  name = "${var.projectname}-cluster"
}

resource "aws_launch_configuration" "grp3-lc" {
  name = "${var.projectname}-lc"
  image_id = "ami-064db566f79006111"
  instance_type = var.inst_type
  key_name      = var.inst_key
  user_data = base64encode(data.template_file.userdata.rendered)
  iam_instance_profile = aws_iam_instance_profile.grp3-ip.name
}

resource "aws_autoscaling_group" "grp3-asg" {
  availability_zones = [var.az]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_configuration = aws_launch_configuration.grp3-lc.name
}
data "template_file" "userdata" {
  template = file("userdata.tpl")
  vars = {
    ecs_cluster_name = aws_ecs_cluster.ecscluster.name
  }
}