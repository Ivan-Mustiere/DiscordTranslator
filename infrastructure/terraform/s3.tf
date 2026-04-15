resource "aws_s3_bucket" "app" {
  for_each = var.s3_buckets

  bucket        = each.value
  force_destroy = false

  tags = merge(local.tags, { Name = each.value })
}

resource "aws_s3_bucket_versioning" "app" {
  for_each = aws_s3_bucket.app

  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app" {
  for_each = aws_s3_bucket.app

  bucket = each.value.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  for_each = aws_s3_bucket.app

  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
