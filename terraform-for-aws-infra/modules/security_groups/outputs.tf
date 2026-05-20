output "bastion_sg_id" {
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_sg.id
}

output "backend_sg_id" {
  description = "The ID of the backend security group"
  value       = aws_security_group.backend_sg.id
}

output "database_sg_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.database_sg.id
}