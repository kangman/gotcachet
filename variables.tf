variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "web_subnet_1" {
  description = "CIDR for web subnet 1"
  default     = "10.0.0.0/24"
}
variable "web_subnet_2" {
  description = "CIDR for public subnet"
  default     = "10.0.1.0/24"
}
variable "db_subnet_1" {
  description = "CIDR for private subnet"
  default     = "10.0.2.0/24"
}

variable "db_subnet_2" {
  description = "CIDR for private subnet"
  default     = "10.0.3.0/24"
}

/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-1 = "ami-049d8641" 
    us-east-1 = "ami-a6b8e7ce"
  }
}
