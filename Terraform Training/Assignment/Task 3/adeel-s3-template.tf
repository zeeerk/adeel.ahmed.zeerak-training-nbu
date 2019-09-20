provider "aws" {
  profile    = "281668362239_Allowed_IAM_N.Virgina_CodeCommit"
  region     = var.region
}

# ----------------------->>>>>S3 Bucket 1
resource "aws_s3_bucket" "adeel-tf-bucket-1" {
  bucket = "${var.bucket1Name}"
  acl    = "private"
}

# ----------------------->>>>>S3 Bucket 2
resource "aws_s3_bucket" "adeel-tf-bucket-2" {
  bucket = "${var.bucket2Name}"
  acl    = "private"
}