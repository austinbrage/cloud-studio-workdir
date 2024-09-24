output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID de la Subnet creada"
  value       = aws_subnet.main.id
}

output "security_group_id" {
  description = "ID del Security Group creado"
  value       = aws_security_group.main.id
}

output "internet_gateway_id" {
  description = "ID de la Internet Gateway creada"
  value       = aws_internet_gateway.main.id
}

output "route_table_id" {
  description = "ID de la Route Table creada"
  value       = aws_route_table.main.id
}

output "key_pair_id" {
  description = "The ID of the key pair"
  value       = var.create_key_pair ? aws_key_pair.main[0].id : null
}

output "key_pair_name" {
  description = "The NAME of the key pair"
  value       = var.create_key_pair ? aws_key_pair.main[0].key_name : null
}
