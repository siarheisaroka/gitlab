data "google_service_account" "def-sa" {
  account_id = "583016262112-compute@developer.gserviceaccount.com"
  project    = var.project
}

data "google_project" "current" {
  project_id = "saroka-gc-bootcamp"
}

data "google_storage_bucket" "techplace" {
  name = "techplace"
}

data "google_compute_health_check" "ssh" {
  name    = "autohealing-ssh-check"
  project = var.project
}
