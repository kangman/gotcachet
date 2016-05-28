resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "cachet-cluster-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "db.r3.large"
  publicly_accessible = "false"
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "cachet-cluster"
  availability_zones = ["us-east-1a","us-east-1c"]
  database_name = "${var.db_name}"
  master_username = "${var.db_user}"
  master_password = "${var.db_passwd}"
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  vpc_security_group_ids = ["${aws_security_group.cachet-db.id}","${aws_security_group.cachet-web.id}"]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
