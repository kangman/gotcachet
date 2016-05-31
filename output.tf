output "db.subnet.1" {
  value = "${aws_subnet.db1.id}"
}

output "db.subnet.2" {
  value = "${aws_subnet.db2.id}"
}

output "cachet.vpc-id" {
  value = "${aws_vpc.cachet.id}"
}

output "web.subnet.1" {
  value = "${aws_subnet.web1.id}"
}

output "web.subnet.2" {
  value = "${aws_subnet.web2.id}"
}

output "web.secgroup" {
  value = "${aws_security_group.cachet-web.id}"
}

output "elb.secgroup" {
  value = "${aws_security_group.cachet-elb.id}"
}

output "elb.subnet.1" {
  value = "${aws_subnet.elb1.id}"
}

output "elb.subnet.2" {
  value = "${aws_subnet.elb2.id}"
}
