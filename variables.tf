variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}

variable "task_definition_family" {
  description = "Name of the ECS task definition family."
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service."
  type        = string
}

variable "desired_count" {
  description = "Number of desired tasks to run in the service."
  type        = number
  default     = 1
}

variable "app_image" {
    type = string
  }

variable "Container-name" {
  type = string
}

variable "containerPort" {
  type = number
}

variable "hostPort" {
  type = number
}

variable "profile_name" {
  type = string
  
}

