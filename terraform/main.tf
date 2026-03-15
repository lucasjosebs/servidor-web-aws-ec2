terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

# Grupo de Segurança para permitir acesso Web
resource "aws_security_group" "web_server_sg" {
  name        = "Web Server security group"
  description = "Security group for my web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instância EC2 baseada no Laboratório
resource "aws_instance" "web_server" {
  ami           = "ami-0c7217cdde317cfec" # Amazon Linux 2023
  instance_type = "t3.micro"               
  
  # Ativa a proteção contra encerramento 
  disable_api_termination = false

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  # Script de User Data personalizado
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              cat <<INNEREOF > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="pt-br">
              <head>
                  <meta charset="UTF-8">
                  <title>Servidor Ativo</title>
                  <style>
                      body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
                      .card { background: white; padding: 3rem; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
                      h1 { color: #1e272e; margin-bottom: 10px; }
                      p { color: #485460; line-height: 1.6; }
                      .status-container { margin-top: 20px; padding: 10px; background: #e8f8f5; border-radius: 8px; }
                      .status { color: #05c46b; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
                  </style>
              </head>
              <body>
                  <div class="card">
                      <h1>🚀 Instância Online</h1>
                      <p>O servidor web foi provisionado com sucesso via <b>User Data</b> e está pronto para uso.</p>
                      <div class="status-container">
                          <span class="status">● Status: Operacional</span>
                      </div>
                  </div>
              </body>
              </html>
              INNEREOF
              chmod 644 /var/www/html/index.html
              EOF

  # Configuração de armazenamento do bloco raiz
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "Web Server"
  }
}