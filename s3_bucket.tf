#------------------------------------------------------------------------------
# AWS S3 Bucket:
#------------------------------------------------------------------------------
resource "aws_s3_bucket" "test_s3_bucket" {
  bucket        = "test-s3-bucket"
  force_destroy = true
}
