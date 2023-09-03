resource "aws_iam_role" "codepipeline" {
  name = "${var.prefix}-codepipeline-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codepipeline.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline" {
  name = "${var.prefix}-codepipeline-policy"
  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow"
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObject",
        ]
        "Resource" : [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "codestar-connections:UseConnection"
        ]
        "Resource" : [
          aws_codestarconnections_connection.this.arn
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
        ]
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "iam:PassRole",
        ]
        "Resource" : [
          "*",
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeTasks",
          "ecs:ListTasks",
          "ecs:RegisterTaskDefinition",
          "ecs:UpdateService",
        ]
        "Resource" : [
          "*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline.arn
}

resource "aws_iam_role" "codebuild" {
  name = "${var.prefix}-codebuild-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codebuild.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild" {
  name = "${var.prefix}-codebuild-policy"
  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow"
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        "Resource" : [
          "*",
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObjectAcl",
          "s3:PutObject",
        ]
        "Resource" : [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      },
      {
        "Effect" : "Allow"
        "Action" : [
          "ecr:*",
        ]
        "Resource" : [
          "*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild.arn
}
