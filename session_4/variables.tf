variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}

variable "region" {
  type        = string
  description = "Region in which the resources will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}
