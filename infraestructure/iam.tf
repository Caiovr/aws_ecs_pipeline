resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# Attach a policy to the ECS task execution role that allows read/write access to the S3 buckets.
resource "aws_iam_policy" "ecs_s3_policy" {
  name = "ecs-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect = "Allow",
        Resource = [
          aws_s3_bucket.bucket1.arn,
          aws_s3_bucket.bucket2.arn
        ]
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = aws_cloudwatch_log_group.log-group.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_s3_policy_attachment" {
  policy_arn = aws_iam_policy.ecs_s3_policy.arn
  role       = aws_iam_role.ecs_execution_role.name
}