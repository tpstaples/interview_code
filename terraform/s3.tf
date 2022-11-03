resource "aws_s3_bucket" "ecs_s3_bucket" {
    bucket = "${var.nyc_vpc}-ecs-s3-bucket"
    acl = "private"

    tags = {
        Name = "${var.nyc_vpc}-ecs-s3-bucket"
    }
}


