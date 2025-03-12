resource "aws_iam_policy" "service_catalog_user_policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = data.aws_iam_policy_document.service_catalog_user_policy.json
}

data "aws_iam_policy_document" "service_catalog_user_policy" {
  statement {
    actions = [
      "servicecatalog:SearchProductsAsAdmin",
      "servicecatalog:DescribeProduct",
      "servicecatalog:ProvisionProduct",
      "servicecatalog:DescribeProvisionedProduct"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "example" {
  user       = var.user_name
  policy_arn = aws_iam_policy.service_catalog_user_policy.arn
}
#IAM Role
resource "aws_iam_role" "service_catalog_role" {
  name               = "SCLaunch-S3product-12"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "GivePermissionsToServiceCatalog",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "servicecatalog.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::664418994073:root"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringLike" : {
            "aws:PrincipalArn" : [
              "arn:aws:iam::664418994073:role/TerraformEngine/TerraformExecutionRole*",
              "arn:aws:iam::664418994073:role/TerraformEngine/ServiceCatalogExternalParameterParserRole*",
              "arn:aws:iam::664418994073:role/TerraformEngine/ServiceCatalogTerraformOSParameterParserRole*"
            ]
          }
        }
      }
    ]
  })
}
 
 
# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.service_catalog_role.name
}
 
 
resource "aws_iam_policy" "this" {
  name        = "S3ResourceCreationAndArtifactAccessPolicy12"
  description = "create and manage S3 buckets"
 
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "s3:ExistingObjectTag/servicecatalog:provisioning" : "true"
          }
        }
      },
      {
        "Action" : [
          "s3:CreateBucket*",
          "s3:DeleteBucket*",
          "s3:Get*",
          "s3:List*",
          "s3:PutBucketTagging"
        ],
        "Resource" : "arn:aws:s3:::*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "resource-groups:CreateGroup",
          "resource-groups:ListGroupResources",
          "resource-groups:DeleteGroup",
          "resource-groups:Tag"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "tag:GetResources",
          "tag:GetTagKeys",
          "tag:GetTagValues",
          "tag:TagResources",
          "tag:UntagResources"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}
 
output "policy_arn" {
  value = aws_iam_policy.this.arn
}
 
# Output the IAM Role ARN
output "role_arn" {
  value = aws_iam_role.service_catalog_role.arn
}


