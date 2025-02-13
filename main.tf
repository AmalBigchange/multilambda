#module to call the s3 main.tf to create a zip of the source code and upload it to s3
module "s3_code_upload" {
    source = "./modules/s3" # this is the path to the s3 module folder
    #bucket_name = "bucket.name" /use this line to give it a custom bucket name if not it will use the default 
    source_file = "./codefile.py"
  
}

