resource "aws_cloudwatch_event_rule" "every_one_minute" {
  name                = "every-one-minute"
  description         = "Fires every one minutes"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "check_foo_every_one_minute" {
  rule      = aws_cloudwatch_event_rule.every_one_minute.name
  target_id = "lambda"
  arn       = aws_lambda_function.reminder.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reminder.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_one_minute.arn
}

resource "aws_lambda_function" "reminder" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "gamebox_reminder"
  role             = aws_iam_role.iam_for_lambda_tf.arn
  handler          = "sms.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
  environment {
    variables = {
      mobile = var.mobile
    }
  }
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

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

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_inline.zip"
  source {
    content  = <<EOF
import boto3
import os

session = boto3.Session()
sns_client = session.client('sns')

def handler(event, context):
    response = sns_client.publish(
        PhoneNumber=os.environ['mobile'],
        Message='Warning: Gamebox stack is running!',
        MessageAttributes={
            'AWS.SNS.SMS.SenderID': {
                'DataType': 'String',
                'StringValue': 'SQUIGGLE'
            },
            'AWS.SNS.SMS.SMSType': {
                'DataType': 'String',
                'StringValue': 'Transactional'
            }
        }
    )
    return 'OK'
EOF
    filename = "sms.py"
  }
}

resource "aws_iam_role_policy" "frontend_lambda_role_policy" {
  name   = "lambda-gamebox-reminder-role-policy"
  role   = aws_iam_role.iam_for_lambda_tf.id
  policy = data.aws_iam_policy_document.lambda_log_and_invoke_policy.json
}

data "aws_iam_policy_document" "lambda_log_and_invoke_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "SNS:Publish"
    ]
    resources = ["*"]
  }

}