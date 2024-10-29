variable "http_port" {
  description = "Port for HTTP health check"
  type        = number
  default     = 30080
}

variable "https_port" {
  description = "Port for HTTPS health check"
  type        = number
  default     = 30443
}

variable "zone" {
  description = "Zone for the instance group"
  type        = string
  default     = "us-central1-a"
}

variable "domains" {
  description = "Domain names for the SSL certificate"
  type        = list(string)
  default     = ["example.com"]
}

variable "instance_group" {
  description = "List of instances for the instance group"
  type        = list(string)
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}

