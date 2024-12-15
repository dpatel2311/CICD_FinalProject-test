output "s3_website_url" {
  value = "http://${aws_s3_bucket.static_website.bucket}.s3-website-us-east-1.amazonaws.com"
}

output "lambda_function_name" {
  value = aws_lambda_function.text_function.function_name
}