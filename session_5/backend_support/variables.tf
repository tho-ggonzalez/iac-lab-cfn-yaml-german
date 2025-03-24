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
