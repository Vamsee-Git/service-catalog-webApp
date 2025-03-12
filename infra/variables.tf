variable "portfolio_name" {
  description = "The name of the AWS Service Catalog portfolio"
  type        = string
  default     = "terraform-portfolio"
}

variable "product_name" {
  description = "The name of the AWS Service Catalog product"
  type        = string
  default     = "s3-product"
}

# You can define other variables in a similar fashion if needed.
