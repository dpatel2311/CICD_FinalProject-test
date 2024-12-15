resource "aws_lambda_function" "text_function" {
  function_name = "Function-8934575"
  handler       = "handler.handler"
  runtime       = "nodejs22.x"
  role          = aws_iam_role.lambda_exec.arn
  //source_code_hash = filebase64sha256("../lambda/package.zip")
  filename      = "../lambda/package.zip"

    environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.static_website.bucket
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.text_function.function_name
  principal     = "apigateway.amazonaws.com"
}
