resource "aws_ecr_repository" "this" {
  name         = "nginx"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}