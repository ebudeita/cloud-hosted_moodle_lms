variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Name used to identify project resources."
  type        = string
  default     = "moodle-portfolio"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private database subnets."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "Existing EC2 key-pair name."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Public IP address allowed to connect through SSH."
  type        = string
}

variable "db_instance_class" {
  description = "RDS database instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the Moodle database."
  type        = string
  default     = "moodle"
}

variable "db_username" {
  description = "Database administrator username."
  type        = string
  default     = "moodleadmin"
}
