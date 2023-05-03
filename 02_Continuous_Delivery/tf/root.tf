terraform {
  backend "gcs" {
    bucket = "techplace"
    prefix = "terraform/state/skillbox_02"
  }
  required_providers {
    local = {
      version = "~> 2.1"
    }
    google = {
      source = "hashicorp/google"
      version = "4.63.1"
    }
  }

}
provider "google" {
  project = var.project
  region  = "us-central1"
  zone    = "us-central1-a"
}

