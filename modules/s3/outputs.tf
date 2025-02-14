output "output_path" {
  value = "lambda_${formatdate("YYYYMMDDHHmmss", timestamp())}.zip"
  description = "The output path of the zipped source code file."
}