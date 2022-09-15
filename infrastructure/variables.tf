variable "bucket_name_destination" {
    type = string
    default = "lambda-etl-destination"
}
variable "bucket_name_deployemennt" {
    type = string
    default = "etl-package-deployement"
}
variable "folder_name" {
    type = string
    default = "landing"
}
variable "package_name" {
    type = string
    default = "aws-lambda-etl.zip"
}
variable "docker_image" {
    type = string
    default = "137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest"
}
