# ecr images to creat custom docker images for lambda deployement
resource "aws_ecr_repository" "aws-lambda-etl" {
  name = "aws-lambda-etl"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}