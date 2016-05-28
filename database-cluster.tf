resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "cachet-cluster-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "db.r3.large"
  publicly_accessible = "false"
  db_subnet_group_name =
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "cachet-cluster"
  availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
  database_name = "${var.db_name}"
  master_username = "${var.db_user}"
  master_password = "${var.db_passwd}"
  db_subnet_group_name = ""
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
