terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.6.0"
    }
  }
}

provider "google" {
  project = "projectcsvtoparquet"
  region = "europe-west2"
  zone = "europe-west2-a"
}
