# this allow s3 to trigger lambda function
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.etl_pipelinne_transformer.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda-etl-destination.arn
}
