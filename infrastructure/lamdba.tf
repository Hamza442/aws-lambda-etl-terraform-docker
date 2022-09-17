# lambda function to writ json file extracted from api
resource "aws_lambda_function" "etl_pipelinne_ingestor" {
  image_uri     = var.docker_image
  package_type  = "Image" 
  function_name = "etl_pipelinne_ingestor"
  handler       = "app.lambda_ingestor"
  runtime       = "python3.9"
  memory_size   = 1024
  timeout       = 10
  role          = aws_iam_role.lambda_etl_role.arn
  # this architecture for docker images created using mac
  architectures = ["arm64"]
    environment {
    variables = {
      BUCKET_NAME = var.bucket_name_destination
      FOLDER = var.folder_name_raw
      #PYTHONPATH = "app"
    }
  }

}

resource "aws_lambda_function" "etl_pipelinne_transformer" {
  image_uri     = var.docker_image
  package_type  = "Image" 
  function_name = "etl_pipelinne_transformer"
  handler       = "app.lambda_transform"
  runtime       = "python3.9"
  memory_size   = 1024
  timeout       = 180
  role          = aws_iam_role.lambda_etl_role.arn
  # this architecture for docker images created using mac
  architectures = ["arm64"]
    environment {
      variables = {
      BUCKET_NAME = var.bucket_name_destination
      FOLDER = var.folder_name_transformed
      #PYTHONPATH = "app"
    }
  }
  # docker image has CMD for ingestor
  # we want to override that configuration when deploying transformer lambda function
  # this will override docker file configuration
  image_config {
    # path of application in docker image
    command =  ["app.lambda_transform"]
  }

}