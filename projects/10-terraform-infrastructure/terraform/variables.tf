variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Existing AWS key pair name for SSH access"
  type        = string
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "terraform-devops-lab"
}


