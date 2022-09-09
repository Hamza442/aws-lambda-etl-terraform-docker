provider aws{
  profile = "aws-lambda-etl-user"
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket                  = "etl-terraform-state-bucket"
    key                     = "plans/terraform-state-file"
    region                  = "us-east-1"
    profile                 = "aws-lambda-etl-user"
  }
}
