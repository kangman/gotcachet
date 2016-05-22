resource "aws_subnet" "web1" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.web_subnet_1}"

    tags {
        Name = "web"
    }
}

resource "aws_subnet" "web2" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.web_subnet_2}"

    tags {
        Name = "web"
    }
}


