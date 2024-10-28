# Cấu hình SSH Firewall Rule
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

# Cấu hình HTTP và HTTPS Firewall Rule
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["k8s"]
}
# Cấu hình Firewall Rule cho các port của worker nodes
resource "google_compute_firewall" "allow_port-worker" {
  name    = "allow-port-worker"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30080", "30443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["worker"]
}
# Cấu hình Firewall Rule cho Health Check
resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30080", "30443"]  # Các cổng mà Health Check cần kiểm tra
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]  # IP của Google Load Balancer Health Check
  target_tags   = ["worker"]
}