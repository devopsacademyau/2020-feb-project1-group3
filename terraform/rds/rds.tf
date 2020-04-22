resource "aws_rds_cluster" "rdsclu" {
    cluster_identifier      = "${var.project_name}-db-cluster"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.07.2"
    db_subnet_group_name    = var.db_subnet_group_name
    vpc_security_group_ids  = [aws_security_group.rds-apps.id]
    availability_zones      = var.availability_zones
    database_name           = var.db_name
    master_username         = var.db_user_name
    master_password         = var.db_password # the password will be repalced when security manager set up
    backup_retention_period = 1
    deletion_protection     = false
    apply_immediately       = true
    skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
    count                  = 1
    identifier             = "${var.project_name}-rds-instance"
    cluster_identifier     = aws_rds_cluster.rdsclu.id
    instance_class         = "db.r4.large" # this is the smallest instance can be use for the engine
    engine                 = "aurora-mysql"
    engine_version         = "5.7.mysql_aurora.2.07.2" #serverless is not supported for this version 
    db_subnet_group_name   = var.db_subnet_group_name
}


resource "aws_security_group" "rds-apps" {
    name   = "${var.project_name}-sg"
    vpc_id = var.vpc_id

    lifecycle {
        create_before_destroy = true
    }

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = [var.vpc_cidr]
        #security_groups = [module.ecs_apps.ecs_nodes_secgrp_id] This probably will need after setting up ecs
        # description     = "From ECS Nodes"
    }
}

output "rds_host" {
    value = aws_rds_cluster.rdsclu.endpoint
}

resource "aws_ssm_parameter" "db-host" {
    name = var.wordpress_db_host_parameter
    description = "The wordpress db host"
    type        = "String"
    value       = "${aws_rds_cluster.rdsclu.endpoint}:3306"
}

resource "aws_ssm_parameter" "db-user" {
    name = var.wordpress_db_user_parameter
    description = "The wordpress db user"
    type        = "String"
    value       = var.db_user_name
}

resource "aws_ssm_parameter" "db-passowrd" {
    name = var.wordpress_db_password_parameter
    description = "The wordpress password"
    type        = "SecureString"
    value       = random_password.password.result
}

resource "aws_ssm_parameter" "db-name" {
    name = var.wordpress_db_name_parameter
    description = "The wordpress db name"
    type        = "String"
    value       = var.db_name
}