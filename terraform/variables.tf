variable "credentials" {
  description = "Path to Google Cloud service account credentials"
  default     = "/terraform/keys/gcp-credentials.json"
}

variable "location" {
  description = "Google Cloud project location"
  default     = "US"
}

variable "project" {
  description = "Google Cloud project ID"
  default     = "artful-palace-451517-f8"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "BigQuery dataset name"
  default     = "etl_dataset"
}

variable "gcs_bucket_name" {
  description = "Google Cloud Storage bucket name"
  default     = "artful-palace-451517-f8"
}

variable "gcs_storage_class" {
  description = "Storage class for GCS bucket"
  default     = "STANDARD"
}
