resource "aws_kms_key" "ecr_kms_key" {
  description             = "KMS key for S3 encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_ecr_repository" "api" {
  name                 = "${var.prefix}crud-app"
  force_delete         = true
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr_kms_key.arn
  }

  tags = {
    Name = "${var.prefix}ecr"
  }
}