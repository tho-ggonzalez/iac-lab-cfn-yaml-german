variable "prefix" {
  type        = string
  description = "Prefix for the resources"
  default     = "gg-iac-lab-"
}

variable "region" {
  type        = string
  description = "Region in which the resources will be created"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "192.168.1.0/25"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
}

variable "db_username" {
  type        = string
  description = "Username for the database"
}
