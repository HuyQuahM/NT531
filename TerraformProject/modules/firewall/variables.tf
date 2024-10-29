variable "network" {
  description = "The network to which the firewall rules are applied"
  type        = string
  default     = "default"
}

variable "ssh_source_ranges" {
  description = "Source IP ranges allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_target_tags" {
  description = "Target tags for SSH firewall rule"
  type        = list(string)
  default     = ["ssh"]
}

variable "http_https_source_ranges" {
  description = "Source IP ranges allowed for HTTP and HTTPS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_https_target_tags" {
  description = "Target tags for HTTP and HTTPS firewall rule"
  type        = list(string)
  default     = ["k8s"]
}

variable "worker_source_ranges" {
  description = "Source IP ranges allowed for worker node ports"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "worker_target_tags" {
  description = "Target tags for worker firewall rule"
  type        = list(string)
  default     = ["worker"]
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}
