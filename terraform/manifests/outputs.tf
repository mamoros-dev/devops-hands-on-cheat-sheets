output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID created by module"
}

output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP of the created web server"
}