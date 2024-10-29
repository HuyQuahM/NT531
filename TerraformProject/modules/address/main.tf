# Địa chỉ IP tĩnh cho master node
resource "google_compute_address" "k8s_master_ip" {
  name         = var.master_name
  region       = var.region
  address_type = "INTERNAL"
  project      = var.project
}

# Địa chỉ IP tĩnh cho worker nodes
resource "google_compute_address" "k8s_worker_ip" {
  count        = var.worker_count
  name         = "${var.worker_name}-${count.index}"
  region       = var.region
  address_type = "INTERNAL"
  project      = var.project
}
