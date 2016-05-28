resource "aws_subnet" "elb1" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.elb_subnet_1}"
    availability_zone = "${var.elb_az1}"
    tags {
        Name = "cachet-web"
    }
}

resource "aws_subnet" "elb2" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.elb_subnet_2}"
    availability_zone = "${var.elb_az2}"
    tags {
        Name = "cachet-web"
    }
}
