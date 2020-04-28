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

tag = "project1-group3"
private_subnet_id = "subnet-0788216e144237a43"
ecs_nodes_sg_id = "TBC"
vpc_id = "vpc-0df4893c1874b0585"
vpc_cidr = "10.0.0.0/16"

security_group = [
    {
        id = "sg-0b871edaf2855e076"
    }
]

az = [
    "ap-southeast-2a"
]
inst_type = "t2.micro"
inst_key = "awskey"
ami_id = "ami-064db566f79006111"
asg_desired_capac = "1"
asg_max_size = "1"
asg_min_size = "1"

