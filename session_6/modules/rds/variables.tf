variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources will be deployed"
  type        = string
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "ecs_security_group_id" {
  type        = string
  description = "ID of the security group for the ECS service"
}

variable "intra_subnets" {
  type        = list(string)
  description = "List of intra subnets"
}