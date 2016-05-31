/* create security group without rules */

resource "aws_security_group" "cachet-db" {
  name = "cachet-db"
  description = "cachet db security group"
  vpc_id = "${aws_vpc.cachet.id}"

  tags {
    Name = "cachet-db-secgroup"
  }
}

resource "aws_security_group" "cachet-web" {
  name = "cachet-web"
  description = "cachet web security group"
  vpc_id = "${aws_vpc.cachet.id}"

  tags {
    Name = "cachet-web-secgroup"
  }
}


resource "aws_security_group" "cachet-elb" {
  name = "cachet-elb"
  description = "cachet elb security group"
  vpc_id = "${aws_vpc.cachet.id}"

  tags {
    Name = "cachet-elb-secgroup"
  }
}
/* create security rules and attach to security groups */

resource "aws_security_group_rule" "cachet-db-rule-ingress" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"

    security_group_id = "${aws_security_group.cachet-db.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-db-rule-egress" {
    type = "egress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"

    security_group_id = "${aws_security_group.cachet-web.id}"
    source_security_group_id = "${aws_security_group.cachet-db.id}"
}

resource "aws_security_group_rule" "cachet-elb-rule-ingress-http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"

    security_group_id = "${aws_security_group.cachet-elb.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-elb-rule-ingress-https" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"

    security_group_id = "${aws_security_group.cachet-elb.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-web-rule-ingress-http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-web-rule-ingress-https" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-web-rule-ingress-ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.cachet-web.id}"
}


resource "aws_security_group_rule" "cachet-web-rule-egress" {
    type = "egress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"


    security_group_id = "${aws_security_group.cachet-db.id}"
    source_security_group_id = "${aws_security_group.cachet-web.id}"
}

resource "aws_security_group_rule" "cachet-elb-rule-ingress-80" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.cachet-elb.id}"
}

resource "aws_security_group_rule" "cachet-elb-rule-ingress-443" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.cachet-elb.id}"
}

resource "aws_security_group_rule" "cachet-elb-rule-egress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.cachet-elb.id}"
}
