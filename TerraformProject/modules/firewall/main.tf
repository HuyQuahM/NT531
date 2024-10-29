# Cấu hình SSH Firewall Rule
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.network
  project      = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = var.ssh_target_tags
}

# Cấu hình HTTP và HTTPS Firewall Rule
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = var.network
  project      = var.project

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.http_https_source_ranges
  target_tags   = var.http_https_target_tags
}

# Cấu hình Firewall Rule cho các port của worker nodes
resource "google_compute_firewall" "allow_port_worker" {
  name    = "allow-port-worker"
  network = var.network
  project      = var.project

  allow {
    protocol = "tcp"
    ports    = ["30080", "30443"]
  }

  source_ranges = var.worker_source_ranges
  target_tags   = var.worker_target_tags
}
