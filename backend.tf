terraform {
  backend "s3" {
    bucket = "bucket-gg-gg"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "nosql"
  }
}
