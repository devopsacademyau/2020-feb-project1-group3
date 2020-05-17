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

# tag = "project1-group3"
private_subnet_id = ""
ecs_nodes_sg_id = ""
# vpc_id = "vpc-0df4893c1874b0585"
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
asg_desired_capac = "1"
asg_max_size = "1"
asg_min_size = "1"
containerimage = "048355378787.dkr.ecr.ap-southeast-2.amazonaws.com/pr1-grp3-ecr"