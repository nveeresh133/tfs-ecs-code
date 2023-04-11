resource "aws_ecs_cluster" "qt-cluster" {
  name = "${var.app_name}-${var.app_environment}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

#Log Group on CloudWatch
resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.app_name}-${var.app_environment}-logs"

  tags = {
    Application = var.app_name
    Environment = var.app_environment
  }
}

resource "aws_ecs_cluster_capacity_providers" "capacity" {
   cluster_name = aws_ecs_cluster.qt-cluster.name

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

#need to specify the capacity provider.
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}

# Create ECS task definition
resource "aws_ecs_task_definition" "ecs-task" {
  family                   = var.task_definition_family
  container_definitions = jsonencode([
    {
    "image": "${var.app_image}",
    "cpu": 1024,
    "memory": 2048,
    "name": "${var.Container-name}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": "${var.containerPort}",
        "hostPort": "${var.hostPort}"
      }
    ]
  }
])
 requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
}


#Security Group to avoid external connections to the containers.
resource "aws_security_group" "service_security_group" {
  vpc_id = aws_vpc.aws-vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name        = "${var.app_name}-service-sg"
    Environment = var.app_environment
  }
}

# Create ECS service
resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.qt-cluster.name
  task_definition = aws_ecs_task_definition.ecs-task.arn
  desired_count   = var.desired_count

   network_configuration {
    subnets          = aws_subnet.private.*.id
       security_groups = [aws_security_group.service_security_group.id]
  }
}

