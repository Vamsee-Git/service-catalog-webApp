resource "aws_iam_user_policy_attachment" "example" {
  user       = var.user_name
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogEndUserFullAccess"
}
resource "aws_iam_policy" "ec2_servicecatalog_policy" {
  name        = "hello-world"
  description = "Policy to allow Service Catalog to create EC2 instances, access S3 artifacts, and manage resources"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        },
        {
            "Sid": "AllowS3AccessForServiceCatalogProvisioning",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "s3:ExistingObjectTag/servicecatalog:provisioning": "true"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "AllowResourceGroupManagement",
            "Effect": "Allow",
            "Action": [
                "resource-groups:CreateGroup",
                "resource-groups:ListGroupResources",
                "resource-groups:DeleteGroup",
                "resource-groups:Tag",
                "resource-groups:Untag"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowTaggingPermissions",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues",
                "tag:TagResources",
                "tag:UntagResources"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowDBCreationPermissions",
            "Effect": "Allow",
            "Action": [
                "rds:CreateDBInstance",
                "rds:CreateDBSubnetGroup",
                "rds:AddTagsToResource",
                "rds:DescribeDBSubnetGroups",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeAvailabilityZones",
                "rds:ModifyDBInstance",
                "rds:DeleteDBInstance",
                "rds:ModifyDBSubnetGroup",
                "rds:DeleteDBSubnetGroup",
                "rds:ListTagsForResource"
            ],
              "Resource": "*"
          }
    ]
}
POLICY
} 


resource "aws_iam_role" "launch_role" {
  name = "SCLaunch-HelloWorld"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "GivePermissionsToServiceCatalog",
            "Effect": "Allow",
            "Principal": {
                "Service": "servicecatalog.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::664418994073:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringLike": {
                    "aws:PrincipalArn": [
                        "arn:aws:iam::664418994073:role/TerraformEngine/TerraformExecutionRole*",
                        "arn:aws:iam::664418994073:role/TerraformEngine/ServiceCatalogExternalParameterParserRole*",
                        "arn:aws:iam::664418994073:role/TerraformEngine/ServiceCatalogTerraformOSParameterParserRole*"
                    ]
                }
            }
        }
    ]
}
POLICY
} 
resource "aws_iam_role_policy_attachment" "launch_role_policy_attachment" {
  role       = aws_iam_role.launch_role.name
  policy_arn = aws_iam_policy.ec2_servicecatalog_policy.arn
}
# Output the IAM Role ARN
output "role_arn" {
  value = aws_iam_role.launch_role.arn
}
output "policy_arn" {
  value = aws_iam_policy.ec2_servicecatalog_policy.arn
}
