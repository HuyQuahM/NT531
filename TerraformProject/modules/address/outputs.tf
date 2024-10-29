output "master_ip" {
  description = "Static IP for the master node"
  value       = google_compute_address.k8s_master_ip.address
}

output "worker_ips" {
  description = "Static IPs for the worker nodes"
  value       = google_compute_address.k8s_worker_ip[*].address
}
