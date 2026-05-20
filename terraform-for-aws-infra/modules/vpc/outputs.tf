output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.ostad_11_private_subnet_1.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.ostad_11_public_subnet_1.id
}