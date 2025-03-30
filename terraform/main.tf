terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.35.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

locals {
  base_filename  = "world_population"
  current_date   = formatdate("YYYY-MM-DD", timestamp()) 
  full_filename  = "${local.base_filename}_${local.current_date}.csv"
  file_location  = "/terraform/data/${local.full_filename}"
}

# Try to get an existing GCS bucket
data "google_storage_bucket" "existing_bucket" {
  name = var.gcs_bucket_name
}

# Create GCS Bucket if it doesn't exist
resource "google_storage_bucket" "demo_bucket" {
  count         = try(data.google_storage_bucket.existing_bucket.id, null) == null ? 1 : 0
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition { age = 3 }
    action { type = "Delete" }
  }

  lifecycle_rule {
    condition { age = 1 }
    action { type = "AbortIncompleteMultipartUpload" }
  }
}

# Upload a File to GCS
resource "google_storage_bucket_object" "uploaded_file" {
  name   = local.full_filename
  bucket = var.gcs_bucket_name
  source = local.file_location
}

# Try to get an existing BigQuery Dataset
data "google_bigquery_dataset" "existing_dataset" {
  dataset_id = var.bq_dataset_name
}

# Create BigQuery Dataset if it doesn't exist
resource "google_bigquery_dataset" "demo_dataset" {
  count      = try(data.google_bigquery_dataset.existing_dataset.id, null) == null ? 1 : 0
  dataset_id = var.bq_dataset_name
  location   = var.location
}
