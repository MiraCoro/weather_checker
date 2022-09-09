
data aws_caller_identity current {}

resource aws_ecr_repository lambda_repo {
    name = var.repository_name
}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

resource null_resource ecr_image {
    triggers = {
        python_file = md5(file("${path.module}/app/main.py"))
        docker_file = md5(file("${path.module}/app/Dockerfile"))
    }
 
    provisioner "local-exec" {
        command = <<EOF
            aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com
            cd ${path.module}/app
            docker build -t ${aws_ecr_repository.lambda_repo.repository_url}:${var.image_tag} .
            docker push ${aws_ecr_repository.lambda_repo.repository_url}:${var.image_tag}
        EOF
    }
}
data aws_ecr_image lambda_image {
    depends_on = [
        null_resource.ecr_image
    ]
 repository_name = var.repository_name
 image_tag       = var.image_tag
}
