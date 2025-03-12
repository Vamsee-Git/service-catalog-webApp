module "portfolio" {
  source        = "./modules/portfolio"
  name          = var.portfolio_name
  description   = "A portfolio for managing products"
  provider_name = "ExampleProvider"
}

module "product" {
  source            = "./modules/product"
  name              = var.product_name
  owner             = "IT"
  description       = "A product created using a Terraform template"
  distributor       = "ExampleDistributor"
  support_email     = "support@example.com"
  support_description = "Support for this product"
  artifact_name     = "TerraformArtifact"
  artifact_description = "Terraform template for provisioning resources"
  template_url      = "https://s3-terraformtemplate-bucketdfghghj.s3.ap-south-1.amazonaws.com/s3bucket.tar.gz"
  portfolio_id      = module.portfolio.portfolio_id
  role_arn          = module.policy.role_arn
}

module "user" {
  source        = "./modules/user"
  user_name     = "Infra_user"
  portfolio_id  = module.portfolio.portfolio_id
}

module "policy" {
  source           = "./modules/policy"
  policy_name      = "ServiceCatalogUserPolicy"
  policy_description = "Policy for Service Catalog user"
  user_name        = module.user.user_name
}
