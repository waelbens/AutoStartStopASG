resource "aws_lambda_function" "asg-lambda-stop-start" {
  filename         = "functions/asg-lambda-stop-start.zip"
  function_name    = "asg-lambda-stop-start"
  role             = "${aws_iam_role.LambdaASGManagement.arn}"
  handler          = "asg-lambda-stop-start.handler"
  timeout          = "5"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("functions/asg-lambda-stop-start.zip"))}"
}

resource "aws_iam_role" "LambdaASGManagement" {
  name               = "LambdaASGanagement"
  assume_role_policy = "${data.aws_iam_policy_document.LambdaASGManagement.json}"
}

data "aws_iam_policy_document" "LambdaASGManagement" {
  statement {
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "ASGManagement" {
  name   = "ASGManagement"
  role   = "${aws_iam_role.LambdaASGManagement.id}"
  policy = "${data.aws_iam_policy_document.ASGManagement.json}"
}

data "aws_iam_policy_document" "ASGManagement" {
  statement {
    effect = "Allow"

    actions = [
      "autoscaling:*",
    ]

    resources = [
      "*",
    ]
  }
}
