variable "subnet_id" {
  type        = string
  description = "The subnet ID for the bastion instance"
}

variable "security_group_id" {
  type        = string
  description = "The security group ID for the bastion instance"
}

variable "key_pair_name" {
  type        = string
  description = "The key pair name for EC2 access"
}