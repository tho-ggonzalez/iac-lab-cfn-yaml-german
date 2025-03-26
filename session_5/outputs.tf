output "vpc_id" {
  value       = module.main_vpc.vpc_id
  description = "The VPC ID"
}

output "ecr_url" {
  value       = module.ecs.ecr_url
  description = "The Elastic Container Registry (ECR) URL"
}
output "website_url" {
  description = "The website URL."
  value       = format("http://%s/users", aws_lb.lb.dns_name)
}