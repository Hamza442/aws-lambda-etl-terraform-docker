resource "aws_dynamodb_table" "jobs" {
  name             = "jobs"
  hash_key         = "job_id"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "job_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "job_run_details" {
  name             = "job_run_details"
  hash_key         = "job_id"
  range_key        = "job_run_time"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "job_id"
    type = "S"
  }
  
  attribute {
    name = "job_run_time"
    type = "N"
  }
}
