variable "aws_profile" {
  description = "Perfil"
  type        = string
}

variable "aws_region" {
  description = "Região"
  type        = string
}

variable "prefix" {
  description = "Prefixo"
  type        = string
}

variable "aws_vpc" {
  description = "VPC"
  type        = string
}

variable "aws_subnet_a" {
  description = "Subnet A"
  type        = string
}

variable "aws_subnet_b" {
  description = "Subnet B"
  type        = string
}

variable "aws_security_groups" {
  description = "Security Groups"
  type        = string
}

variable "aws_ecr_image" {
  description = "Repositório da Imagem"
  type        = string
}

variable "aws_container_name" {
  description = "Nome do container"
  type        = string
}