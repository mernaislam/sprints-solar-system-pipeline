variable "project" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment for the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
    description = "List of private subnet CIDR blocks"
    type        = list(string)
}

variable "public_subnets" {
    description = "List of private subnet CIDR blocks"
    type        = list(string)
}

variable "azs" {
    description = "List of availability zones to use for the VPC"
    type        = list(string)  
}

variable "cluster_name" {
  description = "EKS cluster name used for subnet tagging"
  type        = string
}