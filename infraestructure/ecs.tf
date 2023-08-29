
resource "aws_ecs_cluster" "my_cluster" {
  name = "${var.app_name}-${var.app_environment}-ecs-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  cpu    = "512" # Adjust the CPU units as needed
  memory = "1024" # Adjust the memory in MiB as needed

  container_definitions = jsonencode([{
    name  = "my-container"
    image = aws_ecr_repository.aws-ecr.repository_url
    log_configuration = {
      log_driver = "awslogs"
      options = {
        "awslogs-group"         = "${aws_cloudwatch_log_group.log-group.id}"
        "awslogs-region"        = "${var.aws_region}"
        "awslogs-stream-prefix" = "${var.app_name}-${var.app_environment}"
      }
    }
  }])
}

resource "aws_ecs_service" "my_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn

  launch_type = "FARGATE"

  network_configuration {
    subnets = ["subnet-032e4a99ef87f9ef3"] # Replace with your subnet IDs
  }
}