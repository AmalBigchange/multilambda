#used an exiting role setup
data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role"
}

#attaches a lambda policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = data.aws_iam_role.existing_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonS3ObjectLambdaExecutionRolePolicy"
}

#finds and exisiting lambda function with a specificed name
data "aws_lambda_function" "existing_lambda" {
  function_name = var.function_name
}

#builds the lambda function
resource "aws_lambda_function" "lambda_handler" {
    function_name = var.function_name
    s3_bucket = var.s3_bucket
    s3_key = var.s3_key
    handler = data.aws_lambda_function.existing_lambda.handler
    runtime = data.aws_lambda_function.existing_lambda.runtime
    role = data.aws_iam_role.existing_lambda_role.arn

    lifecycle {
      ignore_changes = [ 
        function_name,
       ]
    }
}