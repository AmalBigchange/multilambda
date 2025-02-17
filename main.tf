# Module to call the S3 module (main.tf) to create a ZIP of the source code and upload it to S3
module "s3_code_upload" {
    source = "./modules/s3"  # Path to the S3 module folder

    # bucket_name = "bucket.name"  # Uncomment this line to use a custom bucket name; otherwise, the default will be used

    source_file = "./codefile.py"  # Path to the source file that needs to be zipped and uploaded
    output_path = "lambda${formatdate("YYYYMMDDHHmmss", timestamp())}.zip"  
    # Dynamically generating the ZIP file name with a timestamp to ensure uniqueness
}

# Another instance of the S3 module for a different source file
module "s3_code_upload2" {
    source = "./modules/s3"  # Path to the S3 module folder

    # bucket_name = "bucket.name"  # Uncomment this line to use a custom bucket name; otherwise, the default will be used

    source_file = "./codefile3.py"  # Path to another source file to be zipped and uploaded
    output_path = "code${formatdate("YYYYMMDDHHmmss", timestamp())}.zip"  
    # Dynamically generating a different ZIP file name with a timestamp for uniqueness
}

# Module to call the Lambda module (main.tf) to create a Lambda function
module "lambda_code" {
    source = "./modules/lambda"  # Path to the Lambda module folder
    function_name = "mylambda4"  # Name of the Lambda function to be created
    s3_bucket = "s3amal"  # The S3 bucket where the ZIP file is stored
    s3_key = module.s3_code_upload.output_path  # Refers to the ZIP file created by the S3 module
    runtime = "python3.9"  # Runtime environment for the Lambda function
    handler = "lambda_code.handler"  # The handler function in the Lambda code
}

# Another Lambda function instance using a different ZIP file
module "lambda_code2" {
    source = "./modules/lambda"  # Path to the Lambda module folder
    function_name = "mylambda3"  # Name of the second Lambda function
    s3_bucket = "s3amal"  # The S3 bucket where the ZIP file is stored
    s3_key = module.s3_code_upload2.output_path  # Refers to the second ZIP file created by the S3 module
    runtime = "python3.9"  # Runtime environment for the Lambda function
    handler = "lambda_code.handler"  # The handler function in the Lambda code
}
