module "ECS_fargate" {
  source = "./modules/ecs"
#tags variables
app_name        = var.app_name
app_environment = var.app_environment
#ecs variables 
task_definition_family = var.task_definition_family
service_name = var.service_name
desired_count = var.desired_count
hostPort = var.hostPort
containerPort = var.containerPort
app_image = var.app_image
Container-name = var.Container-name
availability_zones = var.availability_zones
public_subnets = var.public_subnets
private_subnets = var.private_subnets

profile_name = var.profile_name
aws_region = var.aws_region
}