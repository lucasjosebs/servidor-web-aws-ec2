output "url_do_servidor" {
  description = "Acesse o seu servidor web através desta URL"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "id_da_instancia" {
  description = "O ID da instância EC2 criada"
  value       = aws_instance.web_server.id
}