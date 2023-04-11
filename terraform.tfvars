# these are used for tags
app_name        = "qt-app"
app_environment = "dev"

#ecs variables 
task_definition_family = "my-ecs-task-family"
service_name = "qt-ecs-service"
desired_count = 2
hostPort = 3000
containerPort = 3000
app_image = "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest"  
Container-name = "qt-container"

# these are zones and subnets examples
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

profile_name = "qt-tooling-veeresh"
aws_region = "us-east-2"