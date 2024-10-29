# Output địa chỉ IP của load balancer HTTP và HTTPS từ module load_balancer
output "load_balancer_http_ip" {
  description = "Public IP of the HTTP load balancer"
  value       = module.load_balancer.load_balancer_http_ip
}

output "load_balancer_https_ip" {
  description = "Public IP of the HTTPS load balancer"
  value       = module.load_balancer.load_balancer_https_ip
}

# Output địa chỉ IP công khai của các worker nodes từ module instance
output "worker_nodes_public_ips" {
  description = "Public IP addresses of the worker nodes"
  value       = module.instance.worker_public_ips
}
