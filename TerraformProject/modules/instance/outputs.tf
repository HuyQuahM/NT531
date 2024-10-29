# Output cung cấp đường dẫn self_link của các instance worker
output "worker_instance_self_links" {
  description = "Self links of the worker instances"
  value       = google_compute_instance.k8s_worker[*].self_link
}

# Output cho IP công khai của các worker nodes
output "worker_public_ips" {
  description = "Public IP addresses of the worker nodes"
  value       = google_compute_instance.k8s_worker[*].network_interface[0].access_config[0].nat_ip
}
