# # data "terraform_remote_state" "base" {
# #   backend = "gcs"
# #   config = {
# #     bucket      = "epam-gcp-tf-state-random"
# #     prefix      = "terraform/state/base/"
# #     credentials = "${file("/home/user1/.gcp/credentials.json")}"

# #   }
# # }

data "google_service_account" "def-sa" {
  account_id = "583016262112-compute@developer.gserviceaccount.com"
  project    = var.project
}

# data "google_compute_network" "tf_vpc" {
#   name    = "${var.studentname}-${var.studentsurname}-01-vpc"
#   project = var.project
# }



# data "google_compute_subnetwork" "us-central1" {
#   project = var.project
#   region  = "us-central1"
#   name    = "siarhei-saroka-01-subnetwork-central"
# }

# data "google_compute_subnetwork" "us-east1" {
#   project = var.project
#   region  = "us-east1"
#   name    = "siarhei-saroka-01-subnetwork-east"
# }

data "google_project" "current" {
  project_id = "saroka-gc-bootcamp"
}

data "google_storage_bucket" "techplace" {
  name = "techplace"
}

