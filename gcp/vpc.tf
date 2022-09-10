variable "project_id" {
    description = "project_id"
}

variable "region" {
    description = "region"
}

provider "google" {
    project = var.project_id
    region = var.region
}

resource "google_compute_network" "this" {
    name = "${var.project_id}-vpc"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "this" {
    name = "${var.project_id}-subnet"
    region = var.region
    network = google_compute_network.this.name
    ip_cidr_range = "10.10.0.0/24"
}