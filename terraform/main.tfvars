projectname = "pr1-grp3"
region = "ap-southeast-2"

public_subnets = [
  {
    name = "public-a"
    cidr = "10.0.10.0/24"
    az   = "ap-southeast-2a"
    publicip = true
  },
  {
    name = "public-b"
    cidr = "10.0.20.0/24"
    az   = "ap-southeast-2b"
    publicip = true
  }
]
private_subnets = [
  {
    name = "private-a"
    cidr = "10.0.11.0/24"
    az = "ap-southeast-2a"
    publicip = false
  },
  {
    name = "private-b"
    cidr = "10.0.21.0/24"
    az = "ap-southeast-2b"
    publicip = false
  }
]

private_subnet_id = ""
ecs_nodes_sg_id = ""
vpc_cidr = "10.0.0.0/16"

security_group = [
    {
        id = ""
    }
]

az = [
    "ap-southeast-2a",
    "ap-southeast-2b"
]
inst_type = "t2.micro"
inst_key = ""
ami_id = "ami-064db566f79006111"
asg_desired_capac = "2"
asg_max_size = "2"
asg_min_size = "1"
account_id = ""
# containerimage = TF_VAR_containerimage
# containerimage = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.projectname}-ecr:${var.sha}"
# containerimage = "048355378787.dkr.ecr.ap-southeast-2.amazonaws.com/pr1-grp3-ecr:1a109f0"
retention_in_days = 30