resource "aws_rds_cluster" "rdsclu" {
    cluster_identifier      = var.cluster_name
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.07.2"
    db_subnet_group_name    = var.db_subnet_group_name
    vpc_security_group_ids  = [aws_security_group.rds-apps.id]
    availability_zones      = var.availability_zones
    database_name           = var.db_name
    master_username         = "admin"
    master_password         = "admin" # the password will be repalced when security manager set up
    backup_retention_period = 1
    deletion_protection     = false
    apply_immediately       = true
    skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
    count                  = 1
    identifier             = "aurora-cluster-instance"
    cluster_identifier     = aws_rds_cluster.rdsclu.id
    instance_class         = "db.r4.large" # this is the smallest instance can be use for the engine
    engine                 = "aurora-mysql"
    engine_version         = "5.7.mysql_aurora.2.07.2" #serverless is not supported for this version 
    db_subnet_group_name   = var.db_subnet_group_name
}


resource "aws_security_group" "rds-apps" {
    name   = var.db_sg_name
    vpc_id = var.vpc_id

    lifecycle {
        create_before_destroy = true
    }

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        #cidr_blocks = aws_vpc.main.cidr_block
        #security_groups = [module.ecs_apps.ecs_nodes_secgrp_id] This probably will need after setting up ecs
        description     = "From ECS Nodes"
    }
}

output "rds_host" {
    value = aws_rds_cluster.rdsclu.endpoint
}