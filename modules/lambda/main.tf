# Using an existing IAM role for the Lambda function
data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role"  # Specifies the name of the existing IAM role to be used
}

# Attaching an AWS-managed policy to the existing IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = data.aws_iam_role.existing_lambda_role.name  # References the existing IAM role
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonS3ObjectLambdaExecutionRolePolicy"  # ARN of the IAM policy to attach
}

# Null resource to ensure Lambda function cleanup before deployment
resource "null_resource" "lambda_destroy" {
  triggers = {
    function_name = var.function_name  # Creates a dependency trigger based on function name
  }

  provisioner "local-exec" {
    command = "aws lambda delete-function --function-name ${var.function_name} || true"
    # Deletes the Lambda function if it exists; avoids failure if the function is not found
  }
}

# Creating the Lambda function
resource "aws_lambda_function" "lambda_handler" {
    function_name = var.function_name  # Name of the Lambda function
    s3_bucket     = var.s3_bucket      # S3 bucket where the Lambda deployment package is stored
    s3_key        = var.s3_key         # S3 key (path) to the Lambda deployment package
    handler       = var.handler        # Handler function within the Lambda code
    runtime       = var.runtime        # Runtime environment for the Lambda function (e.g., python3.8, nodejs14.x)
    role          = var.role           # IAM role that Lambda assumes during execution

    depends_on = [ null_resource.lambda_destroy ]  
    # Ensures the old Lambda function is deleted before creating a new one
}
