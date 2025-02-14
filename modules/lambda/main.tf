#used an exiting role setup
data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role"
}

#attaches a lambda policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = data.aws_iam_role.existing_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonS3ObjectLambdaExecutionRolePolicy"
}


#builds the lambda function
resource "aws_lambda_function" "lambda_handler" {
    function_name = var.function_name
    s3_bucket = var.s3_bucket
    s3_key = var.s3_key
    handler = var.handler
    runtime = var.runtime
    role = var.role
}