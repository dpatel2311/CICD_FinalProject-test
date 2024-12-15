# S3 Bucket
resource "aws_s3_bucket" "static_website" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_tag_name
    Environment = var.environment
  }
}

# S3 Website Configuration
resource "aws_s3_bucket_website_configuration" "static_website_configuration" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = var.index_document_suffix
  }

  error_document {
    key = var.error_document_key
  }
}

# S3 Bucket Policy for Public Access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:*"
        Resource  = ["${aws_s3_bucket.static_website.arn}/*"]
      }
    ]
  })
  depends_on = [
    aws_s3_bucket_public_access_block.public_access
  ]
}

# S3 Public Access Block Overrides
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# Files to Upload (HTML and CSS)
locals {
  files_to_upload = {
    "index.html" = "${path.module}/../src/index.html"
    "styles.css" = "${path.module}/../src/styles.css"
  }
}

# Uploading Web Files to S3
resource "aws_s3_object" "web_files" {
  for_each      = local.files_to_upload
  bucket        = aws_s3_bucket.static_website.id
  key           = each.key
  source        = each.value
  content_type  = lookup(
    {
      "index.html" = "text/html"
      "styles.css" = "text/css"
    },
    each.key,
    "application/octet-stream"
  )
}

# Processing app.js Template and Uploading to S3
data "template_file" "app_js" {
  template = file("${path.module}/../src/app.js.tpl")

  vars = {
    api_gateway_url = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/text"
  }
}

resource "aws_s3_bucket_object" "app_js" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "app.js"
  content      = data.template_file.app_js.rendered
  content_type = "application/javascript"
  etag         = md5(data.template_file.app_js.rendered)
}
