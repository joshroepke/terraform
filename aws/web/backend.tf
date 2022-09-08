terraform {
  backend "s3" {
    bucket = "as-code-tf-state-files"
    key    = "web"
    region = "ca-central-1"
  }
}