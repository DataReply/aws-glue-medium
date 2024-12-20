resource "aws_iam_role" "glue_role" {
  name = "MediumAwsGlueRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "glue_s3_access_policy" {
  name        = "GlueS3AccessPolicy"
  description = "Policy for Glue to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.glue_jobs_bucket.arn,
          "${aws_s3_bucket.glue_jobs_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_role_policy_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_s3_access_policy.arn
}

resource "aws_glue_job" "medium_convert_uppercase" {
  name              = "medium-convert-uppercase"
  role_arn          = aws_iam_role.glue_role.arn
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_jobs_bucket.bucket}/${aws_s3_object.uppercase_job.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--MEDIUM_BUCKET"                    = aws_s3_bucket.glue_jobs_bucket.id
    "--enable-continuous-cloudwatch-log" = "true"
    "--extra-py-files"                   = "s3://${aws_s3_bucket.glue_jobs_bucket.bucket}/${aws_s3_object.glue_utils_zip.key}"
  }
}

resource "aws_glue_job" "medium_convert_lowercase_uppercase" {
  name              = "medium-convert-lowercase-uppercase"
  role_arn          = aws_iam_role.glue_role.arn
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_jobs_bucket.bucket}/${aws_s3_object.lowercase_uppercase_job.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--MEDIUM_BUCKET"                    = aws_s3_bucket.glue_jobs_bucket.id
    "--enable-continuous-cloudwatch-log" = "true"
    "--extra-py-files"                   = "s3://${aws_s3_bucket.glue_jobs_bucket.bucket}/${aws_s3_object.glue_utils_zip.key}"
  }
}
