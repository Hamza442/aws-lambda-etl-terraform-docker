resource "aws_s3_bucket" "lambda-etl-destination" {
  bucket = var.bucket_name_destination
}