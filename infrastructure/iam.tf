## IAM ECS
resource "aws_iam_role" "ecs" {
  name                = "${var.prefix}ECSRole"
  managed_policy_arns = [aws_iam_policy.ecs_policy.arn]
  tags                = local.common_tags
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "ecs_policy" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:Describe*",
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:Describe*",
      "ec2:DetachNetworkInterface",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecs:RunTask",
      "elasticloadbalancing:Describe*",
      "route53:CreateHealthCheck",
      "route53:Get*",
      "route53:List*",
      "route53:UpdateHealthCheck",
      "servicediscovery:Get*",
      "servicediscovery:List*",
      "ses:GetAccount",
      "ses:SendBulkEmail",
      "ses:SendEmail",
      "ssm:DescribeSessions",
      "ssm:StartSession"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutMetricFilter"
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "ecs_policy" {
  name   = "ECSPolicy"
  policy = data.aws_iam_policy_document.ecs_policy.json
}