#==================== This is something to output on terminal======================== 
output "region" {
  value = "${var.region}"
}

output "nyc_vpc_id" {
  value = "${aws_vpc.nyc_vpc.id}"
}

output "public_sn_1_id" {
  value = "${aws_subnet.public_sn_1.id}"
}

output "public_sn_2_id" {
  value = "${aws_subnet.public_sn_2.id}"
}

output "public_sg_id" {
  value = "${aws_security_group.public_sg.id}"
}

output "ecs-instance-role-name" {
  value = "${aws_iam_role.ecs-instance-role.name}"
}