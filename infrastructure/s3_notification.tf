resource "aws_s3_bucket_notification" "lambda-etl-destination_bucket_notification" {
  bucket = aws_s3_bucket.lambda-etl-destination.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.etl_pipelinne_transformer.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix       = var.folder_name_raw
    filter_suffix       = ".json.gz"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}