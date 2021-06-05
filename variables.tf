variable "aws_region" {
  type        = string
  description = "Region where aws instance will be provisioned"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}


variable "instance_keypair" {
  type        = string
  description = "EC2 instance type"
  default     = "May"
}