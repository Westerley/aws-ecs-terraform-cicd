# CRIA O LOAD BALANCE PARA O MAPA DE PROSPECTS
resource "aws_lb" "this" {
  name                       = "${var.prefix}-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.aws_security_groups]
  subnets                    = [var.aws_subnet_a, var.aws_subnet_b]
  enable_deletion_protection = false
  tags                       = local.common_tags
}

resource "aws_lb_target_group" "this" {
  name        = "${var.prefix}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.aws_vpc
  target_type = "ip"
  health_check {
    path                = "/healthz"
    protocol            = "HTTP"
    port                = 80
    interval            = 10
    timeout             = 5
    healthy_threshold   = 4
    unhealthy_threshold = 3
  }
  tags = local.common_tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  tags = local.common_tags
}