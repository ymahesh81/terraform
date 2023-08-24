<<<<<<< HEAD
provider "aws" {
  region                   = "us-east-1"
  profile = "frescoplay"
}

resource "aws_iam_role" "lambda_role" {
 name   = "terraform_aws_lambda_role"
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

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# Generates an archive from content, a file, or a directory of files.

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/hello-python.zip"
}

# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "terraform_lambda_func" {
 filename                       = "${path.module}/python/hello-python.zip"
 function_name                  = "Jhooq-Lambda-Function"
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "hello-python.lambda_handler"
 runtime                        = "python3.8"
 depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}


output "teraform_aws_role_output" {
 value = aws_iam_role.lambda_role.name
}

output "teraform_aws_role_arn_output" {
 value = aws_iam_role.lambda_role.arn
}

output "teraform_logging_arn_output" {
 value = aws_iam_policy.iam_policy_for_lambda.arn
}
=======
terraform {
  //required_version = "3.18"
  required_providers{
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "aws_instance" "ec2_demo" {
   ami = data.aws_ami.amzn_linux.id
  //ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  key_name = var.instance_keypair
}

# resource "aws_security_group" "ssh_sg" {

# ingress = [ {
#   cidr_blocks = [ "0.0.0.0/0" ]
#   description = "SSH_SG"
#   from_port = 22
#   protocol = "tcp"
#   self = false
#   to_port = 22
# } ]
# egress = [ {
#   cidr_blocks = [ "0.0.0.0/0" ]
#   description = "SSH_SG"
#   from_port = 0
#   protocol = "-1"
#   self = false
#   to_port = 0
#   ipv6_cidr_blocks = ["::/0"]
# } ]
# }
>>>>>>> 1ae3388df792c024d56f8cf4adb4bad7837d614d
