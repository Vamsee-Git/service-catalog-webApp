variable "name" {
  description = "Name of the Service Catalog product"
  type        = string
}

variable "owner" {
  description = "Owner of the Service Catalog product"
  type        = string
}

variable "description" {
  description = "Description of the Service Catalog product"
  type        = string
}

variable "distributor" {
  description = "Distributor of the product"
  type        = string
}

variable "support_email" {
  description = "Support email for the product"
  type        = string
}

variable "support_description" {
  description = "Description of the support for the product"
  type        = string
}

variable "artifact_name" {
  description = "Name of the provisioning artifact"
  type        = string
}

variable "artifact_description" {
  description = "Description of the provisioning artifact"
  type        = string
}

variable "template_url" {
  description = "URL to the CloudFormation or Terraform template"
  type        = string
}

variable "portfolio_id" {
  description = "ID of the portfolio where the product will be added"
  type        = string
}

variable "role_arn" {
  description = "IAM role in ARN"
  type        = string
}
