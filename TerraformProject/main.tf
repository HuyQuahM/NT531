# Tạo các địa chỉ IP tĩnh cho các node
resource "google_compute_address" "k8s_master_ip" {
  name    = "k8s-master-ip"
  region  = "us-central1"
  address_type = "INTERNAL"
}
resource "google_compute_address" "k8s_worker_ip" {
  count   = 3
  name    = "k8s-worker-${count.index}-ip"
  region  = "us-central1"
  address_type = "INTERNAL"
}

# Tạo instance cho master node
resource "google_compute_instance" "k8s_master" {
  name         = "k8s-master"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20201014"
    }
  }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    network_ip    = google_compute_address.k8s_master_ip.address  # Gán IP tĩnh cho master node
    access_config {}  # Tạo địa chỉ IP Ephemeral Public
  }

  metadata = {
    ssh-keys = "k8s-admin:${file("D:/Study/TerraformProject/id_rsa.pub")}"  # Public key của bạn
  }

  # Tạo User k8s-admin với quyền sudo
  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Tạo user k8s-admin
    useradd -m -s /bin/bash k8s-admin
    echo "k8s-admin:admin" | chpasswd
    usermod -aG sudo k8s-admin
    echo "k8s-admin ALL=(ALL) ALL" >> /etc/sudoers.d/k8s-admin
    chmod 0440 /etc/sudoers.d/k8s-admin
  EOT

  tags = ["k8s", "ssh"]
}

# Tạo Instance Template cho worker nodes
resource "google_compute_instance" "k8s_workers" {
  count        = 3
  name         = "k8s-worker-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20201014"
    }
  }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    network_ip    = google_compute_address.k8s_worker_ip[count.index].address  # Gán IP tĩnh cho worker node
    access_config {}
  }

  metadata = {
    ssh-keys = "k8s-admin:${file("D:/Study/TerraformProject/id_rsa.pub")}"
  }

  # Tạo User k8s-admin với quyền sudo
  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Tạo user k8s-admin
    useradd -m -s /bin/bash k8s-admin
    echo "k8s-admin:admin" | chpasswd
    usermod -aG sudo k8s-admin
    echo "k8s-admin ALL=(ALL) ALL" >> /etc/sudoers.d/k8s-admin
    chmod 0440 /etc/sudoers.d/k8s-admin
  EOT

  tags = ["k8s", "ssh"]
}
