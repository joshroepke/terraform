resource "random_id" "this" {
  byte_length = 8
}

resource "google_storage_bucket" "this" {
  name          = "${random_id.this.hex}-bucket-tfstate"
  project       = "terraform-automation-342423"  
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}