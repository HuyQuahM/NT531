# Output địa chỉ IP public của load balancer cho HTTP
output "load_balancer_http_ip" {
  description = "The external IP address of the HTTP load balancer"
  value       = google_compute_global_forwarding_rule.http_forwarding_rule.ip_address
}

# Output địa chỉ IP public của load balancer cho HTTPS
output "load_balancer_https_ip" {
  description = "The external IP address of the HTTPS load balancer"
  value       = google_compute_global_forwarding_rule.https_forwarding_rule.ip_address
}