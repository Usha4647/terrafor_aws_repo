resource aws_s3_bucket "s3_bucket" {
    bucket = "usha-s3-bucket01"
    tags = {
      Name = "My terraform s3 bucket"
      Environment = "Dev"
    }
}