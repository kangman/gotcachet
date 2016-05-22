

/* Define our vpc */
resource "aws_vpc" "cachet" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags { 
    Name = "cachet-vpc" 
  }
}