resource "aws_ebs_volume" "ebs_vol" {
    availability_zone = "us-east-1a"
    size = 10  
}