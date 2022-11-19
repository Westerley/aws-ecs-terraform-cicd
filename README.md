## Laboratório Terraform + Github Actions

> Este laboratório foi realizado para ministrar a disciplina de Cultura e Práticas DevOps (PucMinas).

Neste laboratório foi realizado o deploy da infraestrutura AWS com Terraform e CICD com Github Actions para realizar o deploy das imagens Docker no repositório de imagem ECR e a atualização da tag no ECS.

Recursos criados:
- Repositório ECR
- CloudWatch Log Group
- ECS Cluster
- ECS Task Definition
- Template Container Definition
- ECS Service
- Load Balancer Target Group
- Application Load Balancer
- IAM Role 
- IAM Policy
- Backend S3 - Armazenar o tfstate

---

Workflows Github Actions:

- Deploy dos recursos AWS

---

Adicionar os segredos no Github:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

---

Executar scripts Terraform

```sh
$ cd infrastructure

$ terraform init

$ terraform plan

$ terraform apply
```

---