variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "us-east-1"
}
variable "vpc_cidr" {default = "10.0.0.0/16"}

variable "web_subnet_1" {default = "10.0.0.0/24"}
variable "web_subnet_2" {default = "10.0.1.0/24"}
variable "web_az1" {default = "us-east-1a"}
variable "web_az2" {default = "us-east-1c"}

variable "elb_subnet_1" {default = "10.0.4.0/24"}
variable "elb_subnet_2" {default = "10.0.5.0/24"}
variable "elb_az1" {default = "us-east-1a"}
variable "elb_az2" {default = "us-east-1c"}

variable "db_subnet_1" {default = "10.0.2.0/24"}
variable "db_subnet_2" {default = "10.0.3.0/24"}
variable "db_az1" {default = "us-east-1a"}
variable "db_az2" {default = "us-east-1c"}

variable "db_name" {}
variable "db_user" {}
variable "db_passwd" {}


/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-1 = "ami-049d8641"
    us-east-1 = "ami-a6b8e7ce"
  }
}
