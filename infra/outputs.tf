output "portfolio_id" {
  description = "The ID of the Service Catalog portfolio"
  value       = module.portfolio.portfolio_id
}

output "product_id" {
  description = "The ID of the Service Catalog product"
  value       = module.product.product_id
}

output "user_name" {
  description = "The name of the IAM user"
  value       = module.user.user_name
}

output "user_arn" {
  description = "The ARN of the IAM user"
  value       = module.user.user_arn
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = module.policy.policy_arn
}
