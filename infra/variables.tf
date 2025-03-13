variable "portfolio_name" {
  description = "The name of the AWS Service Catalog portfolio"
  type        = string
  default     = "terraform-portfolio-webApp"
}

variable "product_name" {
  description = "The name of the AWS Service Catalog product"
  type        = string
  default     = "webAppproduct"
}

# You can define other variables in a similar fashion if needed.
