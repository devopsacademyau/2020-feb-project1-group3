// create a vpc
resource "aws_vpc" "project1_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
}

// create a public subnet public-a
resource "aws_subnet" "public-a" {
    vpc_id = aws_vpc.project1_vpc.id
    cidr_block = var.public_subnets[0].cidr
    map_public_ip_on_launch = true # this makes it a public subnet
    availability_zone = var.public_subnets[0].az
    tags = {
        Name = var.public_subnets[0].name
    }
}

// create a public subnet public-b
resource "aws_subnet" "public-b" {
    vpc_id = aws_vpc.project1_vpc.id
    cidr_block = var.public_subnets[1].cidr
    map_public_ip_on_launch = true # this makes it a public subnet
    availability_zone = var.public_subnets[1].az
    tags = {
        Name = var.public_subnets[1].name
    }
}

// create a private subnet private-a
resource "aws_subnet" "private-a" {
    vpc_id = aws_vpc.project1_vpc.id
    cidr_block = var.private_subnets[0].cidr
    availability_zone = var.private_subnets[0].az
    tags = {
        Name = var.private_subnets[0].name
    }
}

// create a private subnet private-b
resource "aws_subnet" "private-b" {
    vpc_id = aws_vpc.project1_vpc.id
    cidr_block = var.private_subnets[1].cidr
    availability_zone = var.private_subnets[1].az
    tags = {
        Name = var.private_subnets[1].name
    }
}
// create a internet gateway
resource "aws_internet_gateway" "devopsad-igw" {
    vpc_id = aws_vpc.project1_vpc.id
    tags = {
        Name = "devopsad-igw"
    }
}

// create routing table which points to the internet gateway
resource "aws_route_table" "devopsad-igw-route" {
    vpc_id = aws_vpc.project1_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devopsad-igw.id
    }
    tags = {
        Name = "devopsad-igw-route"
    }
}

// associate routetable with public-a subnet id
resource "aws_route_table_association" "public-a-subnet-association" {
    subnet_id = aws_subnet.public-a.id
    route_table_id = aws_route_table.devopsad-igw-route.id
}

// associate route table with public-b subnet id
resource "aws_route_table_association" "public-b-subnet-association" {
    subnet_id = aws_subnet.public-b.id
    route_table_id = aws_route_table.devopsad-igw-route.id
}


# // create routing table which points to the ngw
# resource "aws_route_table" "devopsad-ngw-route" {
#     vpc_id = aws_vpc.project1_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_nat_gateway.devopsad-ngw.id
#     }
#     tags = {
#         Name = "devopsad-ngw-route"
#     }
# }


// associate routetable with private-a subnet id
# resource "aws_route_table_association" "private-a-subnet-association" {
#     subnet_id = aws_subnet.private-a.id
#     route_table_id = aws_route_table.devopsad-ngw-route.id
# }

// associate routetable with private-b subnet id
# resource "aws_route_table_association" "private-b-subnet-association" {
#     subnet_id = aws_subnet.private-b.id
#     route_table_id = aws_route_table.devopsad-ngw-route.id
# }

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]

  tags = {
    Name = "My DB subnet group"
  }
}

output "subnet_group_name" {
    value = aws_db_subnet_group.db_subnet_group.name
    description = "subnet_group_name"
} 

output "vpc_id" {
  value       = aws_vpc.project1_vpc.id 
  description = "vpc_id"
}