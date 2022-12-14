variable "bucket_name_destination" {
    type = string
    default = "lambda-etl-destination"
}
variable "bucket_name_deployemennt" {
    type = string
    default = "etl-package-deployement"
}
variable "folder_name_raw" {
    type = string
    default = "landing/"
}
variable "folder_name_transformed" {
    type = string
    default = "transformed/"
}
variable "package_name" {
    type = string
    default = "aws-lambda-etl.zip"
}
variable "docker_image" {
    type = string
    default = "111087180641.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest"
}
