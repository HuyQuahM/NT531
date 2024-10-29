variable "region" {
  description = "Region for static IP addresses"
  type        = string
  default     = "us-central1"
}

variable "master_name" {
  description = "Name for the master IP address"
  type        = string
  default     = "k8s-master-ip"
}

variable "worker_name" {
  description = "Base name for the worker IP addresses"
  type        = string
  default     = "k8s-worker"
}

variable "worker_count" {
  description = "Number of worker IP addresses"
  type        = number
  default     = 3
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}

