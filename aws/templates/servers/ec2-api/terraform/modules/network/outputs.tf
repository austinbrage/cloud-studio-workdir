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
