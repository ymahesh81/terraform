terraform {
  backend "s3" {
    bucket = "tfstate-mahesh"
    key    = "tflambda"
    region = "ap-south-1"
  }
}
