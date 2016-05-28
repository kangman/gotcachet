resource "aws_subnet" "web1" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.web_subnet_1}"
    availability_zone = "${var.web_az1}"
    tags {
        Name = "cachet-web"
    }
}

resource "aws_subnet" "web2" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.web_subnet_2}"
    availability_zone = "${var.web_az2}"
    tags {
        Name = "cachet-web"
    }
}
