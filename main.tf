provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"

}

resource "aws_internet_gateway" "cachet-igw" {
    vpc_id = "${aws_vpc.cachet.id}"

    tags {
        Name = "cachet-igw"
    }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.cachet.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.cachet-igw.id}"
}
