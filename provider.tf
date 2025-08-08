terraform {
  required_version = "= 1.5.7"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0" # Choose version compatible with Terraform 1.5.7
    }
  }
}

provider "google" {
  project = "curtisgcpproject"
  region  = "us-east-5"
}
