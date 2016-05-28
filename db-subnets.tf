resource "aws_subnet" "db1" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.db_subnet_az1}"
    availability_zone = "${var.db_az1}"
    tags {
        Name = "cachet-db"
    }

}
resource "aws_subnet" "db2" {
    vpc_id = "${aws_vpc.cachet.id}"
    cidr_block = "${var.db_subnet_az2}"
    availability_zone = "${var.db_az2}"
    tags {
        Name = "cachet-db"
    }
}

resource "aws_db_subnet_group" "default" {
    name = "cachet-subnet-group"
    description = "cachet db subnet group"
    subnet_ids = ["${aws_subnet.db1.id}", "${aws_subnet.db2.id}"]
    tags {
        Name = "cachet-db-subnet-group"
    }
}
