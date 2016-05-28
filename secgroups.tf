resource "aws_security_group" "cachet-db" {
  name = "cachet-db"
  description = "cachet db security group"

  tags {
    Name = "cachet-db-secgroup"
  }
}

resource "aws_security_group" "cachet-web" {
  name = "cachet-web"
  description = "cachet web security group"

  tags {
    Name = "cachet-web-secgroup"
  }
}



resource "aws_security_group_rule" "cachet-db-rule" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-db.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-db-rule" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-db.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-db-rule" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-db.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}
