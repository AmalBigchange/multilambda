data "aws_s3_bucket" "exisitin_bucket" {
  bucket = var.bucket_name
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../../codefile.py"
  output_path = "lambda_handler.zip"
}

resource "aws_s3_object" "lambda_code" {
  bucket = data.aws_s3_bucket.exisitin_bucket.bucket
  key    = "lambda_handler.zip"
  source = "${data.archive_file.lambda_zip.output_path}"
}