resource "aws_s3_bucket" "s3_tfstate_bucket" {
  bucket = "${var.prefix}-tfstate"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.prefix}-tfstate"
  }
}

resource "aws_s3_bucket_versioning" "s3_tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.s3_tfstate_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "s3_kms_key" {
  description             = "KMS key for S3 encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_tfstate_bucket_sse" {
  bucket = aws_s3_bucket.s3_tfstate_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_kms_key.arn
      sse_algorithm      = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_tfstate_bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_tfstate_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
