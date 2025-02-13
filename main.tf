module "s3_code_upload" {
    source = "./modules/s3"
    bucket_name = "s3amal"
    source_file = "./codefile.py"
  
}

