variable "machine_type" {
  description = "Type of machine for the instances"
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "Zone for the instances"
  type        = string
  default     = "us-central1-a"
}

variable "image" {
  description = "Image for the instances"
  type        = string
  default     = "ubuntu-2204-jammy-v20240927"
}

variable "network" {
  description = "Network for the instances"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Subnetwork for the instances"
  type        = string
  default     = "default"
}

variable "ssh_keys" {
  description = "SSH keys for access"
  type        = string
}

variable "master_ip" {
  description = "Static IP for the master instance"
  type        = string
}

variable "worker_ips" {
  description = "List of static IPs for the worker instances"
  type        = list(string)
}

variable "master_tags" {
  description = "Tags for the master instance"
  type        = list(string)
  default     = ["k8s", "ssh"]
}

variable "worker_tags" {
  description = "Tags for the worker instances"
  type        = list(string)
  default     = ["k8s", "ssh", "worker"]
}

variable "worker_count" {
  description = "Number of worker instances"
  type        = number
  default     = 3
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}
