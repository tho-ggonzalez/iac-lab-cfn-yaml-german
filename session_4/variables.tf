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

variable "subnet3_cidr" {
  type        = string
  description = "CIDR block for the third subnet"
}

variable "subnet4_cidr" {
  type        = string
  description = "CIDR block for the fourth subnet"
}

variable "subnet5_cidr" {
  type        = string
  description = "CIDR block for the fifth subnet"
}

variable "subnet6_cidr" {
  type        = string
  description = "CIDR block for the sixth subnet"
}
