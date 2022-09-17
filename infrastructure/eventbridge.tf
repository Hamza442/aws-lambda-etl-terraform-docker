resource "aws_cloudwatch_event_rule" "lambda_ingestor_eventbridge_rule" {
  name = "lambda_ingestor_eventbridge_rule"
  schedule_expression = "rate(15 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_ingestor_eventbridge_target" {
    rule = aws_cloudwatch_event_rule.lambda_ingestor_eventbridge_rule.id
    arn = aws_lambda_function.etl_pipelinne_ingestor.arn
}