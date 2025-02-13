variable "bucket_name" {
  description = "s3 bucket name"
  type = string
  default = "s3amal"
}

variable "source_file" {
  description = "Path to the source file to be uploaded."
  type        = string
}