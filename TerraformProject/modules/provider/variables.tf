variable "credentials" {
  description = "Path to the Google Cloud credentials JSON file"
  type        = string
}

variable "region" {
  description = "Region for Google Cloud resources"
  type        = string
  default     = "us-central1"
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}
