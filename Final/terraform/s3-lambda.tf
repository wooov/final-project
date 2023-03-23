//labmda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17", 
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "s3-lambda" {
  function_name = "s3-lambda"
  handler = "index.handler"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "nodejs18.x"
  memory_size = 128
  timeout = 10
  filename = "s3-lambda.zip"
  source_code_hash = filebase64sha256("s3-lambda.zip")
}

//sns
resource "aws_sns_topic" "default" {
  name = "s3-lambda.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
  
}

//sqs
resource "aws_sns_topic_subscription" "sqs_target" {
  topic_arn = aws_sns_topic.default.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.terraform_queue.arn
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "s3-lambda-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
}


resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.terraform_queue.id

  policy = jsonencode({
    Version: "2012-10-17",
    Id: "sqspolicy",
    Statement: [
      {
        Sid: "First",
        Effect: "Allow",
        Principal: "*",
        Action: "sqs:SendMessage",
        Resource: "${aws_sqs_queue.terraform_queue.arn}",
        Condition: {
          ArnEquals: {
            "aws:SourceArn": "${aws_sns_topic.default.arn}"
          }
        }
      }
    ]
  })
}




