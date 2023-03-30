#------------------------------------------------------------------------------
# AWS IAM Policy:
#------------------------------------------------------------------------------
resource "aws_iam_policy" "test_s3_am_policy" {
  name        = "test-s3-am-policy"
  description = "test - access to source and destination S3 bucket"
  path        = "/"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::test-s3-bucket/*"
      },
    ]
  })
}

#------------------------------------------------------------------------------
# AWS IAM Role:
#------------------------------------------------------------------------------
resource "aws_iam_role" "test_s3_aws_iam_role" {
  name               = "test-s3-aws-iam-role"
  description        = "test - access to source and destination S3 bucket"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#------------------------------------------------------------------------------
# AWS IAM Role Policy Attachment:
#------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "test_s3_policy_attachment" {
  role       = aws_iam_role.test_s3_aws_iam_role.name
  policy_arn = aws_iam_policy.test_s3_am_policy.arn
}

#------------------------------------------------------------------------------
# AWS IAM Instance Profile:
#------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "test_s3_iam_instance_profile" {
  name = "test-s3-iam-instance-profile"
  role = aws_iam_role_policy_attachment.test_s3_policy_attachment
}
