resource "aws_servicecatalog_portfolio" "example" {
  name          = var.name
  description   = var.description
  provider_name = var.provider_name
}

output "portfolio_id" {
  description = "The ID of the Service Catalog portfolio"
  value       = aws_servicecatalog_portfolio.example.id
}
