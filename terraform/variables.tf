# main credscredentials for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "token" {
  description = "AWS session token"
}

variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "region" {
  description = "AWS region"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}

########################### VPC Config ################################

variable "nyc_vpc" {
  description = "VPC for Test environment"
}

variable "vpc_network_cidr" {
  description = "IP addressing for Test Network"
}

variable "public_01_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

variable "public_02_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}
