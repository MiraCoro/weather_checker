resource "aws_iam_role" "lambda_role" {
    name   = "${var.lambda_name}-role"
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

resource "aws_iam_policy" "iam_policy_for_lambda" {
    name         = "${var.lambda_name}-policy"
    path         = "/"
    description  = "AWS IAM Policy for managing AWS lambda role"
    policy = <<EOF
{
    "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
    EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role        = aws_iam_role.lambda_role.name
    policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "terraform_lambda_func" {
    function_name                  = var.lambda_name
    role                           = aws_iam_role.lambda_role.arn
    image_uri                      = var.image_url
    package_type                   = "Image"
    depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}