variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "ap-south-1"
}


variable "project_name" {
  description = "Project name used for tagging AWS resources"
  type        = string
  default     = "project-29-terraform-aws-infra"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


