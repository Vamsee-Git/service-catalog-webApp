resource "aws_servicecatalog_product" "example" {
  name          = var.name
  owner         = var.owner
  description   = var.description
  distributor   = var.distributor
  support_email = var.support_email
  support_description = var.support_description
  type         = "EXTERNAL"

  provisioning_artifact_parameters {
    name         = var.artifact_name
    description  = var.artifact_description
    type         = "EXTERNAL"
    template_url = var.template_url
    disable_template_validation  = true
  }
}

resource "aws_servicecatalog_product_portfolio_association" "example" {
  portfolio_id = var.portfolio_id
  product_id   = aws_servicecatalog_product.example.id
}

resource "aws_servicecatalog_constraint" "example" {
  portfolio_id = var.portfolio_id
  product_id   = aws_servicecatalog_product.example.id
  type         = "LAUNCH"
  description  = "Launch constraint for example product"
  parameters   = jsonencode({
    RoleArn = var.role_arn
  })
}

output "product_id" {
  description = "The ID of the Service Catalog product"
  value       = aws_servicecatalog_product.example.id
}

