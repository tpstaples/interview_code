resource "aws_ecs_cluster" "aetion-ecs-cluster" {
    name = "${var.ecs_cluster}"
}
