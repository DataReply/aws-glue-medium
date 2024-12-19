locals {
  lowercase_uppercase_job_path = "${path.module}/../../code/aws_glue/medium-lowercase-uppercase-glue-job.py"
  uppercase_job_path           = "${path.module}/../../code/aws_glue/medium-uppercase-glue-job.py"
}

resource "aws_s3_bucket" "glue_jobs_bucket" {
  bucket = "glue-utils-medium-bucket"
}

resource "aws_s3_object" "glue_utils_zip" {
  bucket = aws_s3_bucket.glue_jobs_bucket.id
  key    = "corelib.zip"
  source = "../../corelib.zip"
  depends_on = [null_resource.zip_utils]
}

resource "aws_s3_object" "uppercase_job" {
  bucket = aws_s3_bucket.glue_jobs_bucket.id
  key    = "glue-job-code/medium-uppercase-job.py"
  source = local.uppercase_job_path
  etag = md5(file(local.uppercase_job_path))
}

resource "aws_s3_object" "lowercase_uppercase_job" {
  bucket = aws_s3_bucket.glue_jobs_bucket.id
  key    = "glue-job-code/medium-lowercase-uppercase-job.py"
  source = local.lowercase_uppercase_job_path
  etag = md5(file(local.lowercase_uppercase_job_path))
}

resource "null_resource" "zip_utils" {
  triggers = {
    utils_change = md5(join("", fileset("../../code/corelib", "**/*")))
  }

  provisioner "local-exec" {
    command = <<EOT
      cd ../../code &&
      zip -r ../corelib.zip corelib
    EOT
  }
}

resource "null_resource" "delete_zip_file" {
  depends_on = [aws_s3_object.glue_utils_zip]

  provisioner "local-exec" {
    command = "rm ../../corelib.zip"
  }
}
