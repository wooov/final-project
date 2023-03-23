resource "aws_sns_topic" "topic" {
  name = "topic"
}


resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = "${aws_sns_topic.topic.arn}"
  protocol  = "lambda"

  # coming soon
  endpoint  = "${aws_lambda_function.my_lambda.arn}"
}


resource "aws_sns_topic_policy" "policy" {
  arn = "${aws_sns_topic.topic.arn}"

  policy = "${data.aws_iam_policy_document.sns.json}"
}

data "aws_iam_policy_document" "sns" {
  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]
  }
}
