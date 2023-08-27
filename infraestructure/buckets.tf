resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.app_name}-${var.app_environment}-bucket-test-1" # Replace with your first bucket name
  acl    = "private"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "${var.app_name}-${var.app_environment}-bucket-test-2" # Replace with your second bucket name
  acl    = "private"
}