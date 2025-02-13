#referencing the exiting bucket
data "aws_s3_bucket" "exisitin_bucket" {
  bucket = var.bucket_name #getting the bucket name from the variables
}

#ziping the source code
data "archive_file" "lambda_zip" {
  type        = "zip" #type of archive
  source_file = var.source_file #getting the source file from the variable
  output_path = "lambda_handler.zip" # naming the output zip file (could be used as a variable to make it dynamic)
}

#uploading the zip fiel to the s3 bucket
resource "aws_s3_object" "lambda_code" {
  bucket = data.aws_s3_bucket.exisitin_bucket.bucket #referencing which bucket it needs to go to by using the data object above
  key    = "lambda_handler.zip" # pointing to the newly created zip file (could be used as a variable)
  source = data.archive_file.lambda_zip.output_path #providing the path from the archive data object
}