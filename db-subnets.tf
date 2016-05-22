resource "aws_subnet" "db1" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.db_subnet_1}"

    tags {
        Name = "db"
    }

}
resource "aws_subnet" "db2" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.db_subnet_2}"

    tags {
        Name = "db"
    }
}
