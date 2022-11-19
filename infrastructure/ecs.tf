resource "aws_ecs_cluster" "this" {
  name = "${var.prefix}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.common_tags
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${var.prefix}-log-group"
  tags = local.common_tags
}

data "template_file" "container_definitions" {
  template = file("container-definitions.json.tpl")
  vars = {
    aws_ecr_image      = var.aws_ecr_image
    log_group_name     = aws_cloudwatch_log_group.this.name
    log_group_region   = var.aws_region
    aws_container_name = var.aws_container_name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.prefix}-task"
  container_definitions    = data.template_file.container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs.arn
  task_role_arn            = aws_iam_role.ecs.arn
  volume {
    name = "static"
  }
  tags = local.common_tags
}

resource "aws_ecs_service" "this" {
  name            = "${var.prefix}-service"
  cluster         = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.family
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.aws_subnet_a, var.aws_subnet_b]
    security_groups  = [var.aws_security_groups]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.aws_container_name
    container_port   = 80
  }
  tags = local.common_tags
}
