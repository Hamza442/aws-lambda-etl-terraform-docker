# lambda function to writ json file extracted from api
resource "aws_lambda_function" "etl_pipelinne" {
  image_uri     = var.docker_image
  package_type  = "Image" 
  function_name = "etl_pipelinne"
  handler       = "app.lambda_ingest"
  runtime       = "python3.9"
  memory_size   = 1024
  timeout       = 10
  role          = aws_iam_role.lambda_etl_role.arn
    environment {
    variables = {
      BUCKET_NAME = var.bucket_name_destination
      FOLDER = var.folder_name
      #PYTHONPATH = "app"
    }
  }

}
