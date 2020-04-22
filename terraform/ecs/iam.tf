resource "aws_iam_role" "ecsrun" {
    name = "roleecsrun"
    assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}
resource "aws_iam_role_policy_attachment" "ecs_node_role_policy" {
  role       = aws_iam_role.ecsrun.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_instance_profile" "grp3-ip" {
    name    = "pr1-grp3-inst-prof"
    role    = aws_iam_role.ecsrun.name
}

# resource "aws_iam_role_policy" "polecsrun" {
#     name = "rpolecsrun"
#     role = aws_iam_role.ecsrun.id
#     policy = <<-POLICY
#     {
#         "Version": "2012-10-17",
#         "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:DescribeTags",
#                 "ecs:CreateCluster",
#                 "ecs:DeregisterContainerInstance",
#                 "ecs:DiscoverPollEndpoint",
#                 "ecs:Poll",
#                 "ecs:RegisterContainerInstance",
#                 "ecs:StartTelemetrySession",
#                 "ecs:UpdateContainerInstancesState",
#                 "ecs:Submit*",
#                 "ecr:GetAuthorizationToken",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents"
#             ],
#             "Resource": "*"
#         }
#     ]
#     }
#  POLICY
# }
