# Instance cho master node
resource "google_compute_instance" "k8s_master" {
  name         = "k8s-master"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network       = var.network
    subnetwork    = var.subnetwork
    subnetwork_project = var.project
    network_ip    = var.master_ip
    access_config {}
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Tạo user k8s-admin
    useradd -m -s /bin/bash k8s-admin
    echo "k8s-admin:admin" | chpasswd
    usermod -aG sudo k8s-admin
    echo "k8s-admin ALL=(ALL) ALL" >> /etc/sudoers.d/k8s-admin
    chmod 0440 /etc/sudoers.d/k8s-admin
  EOT

  tags = var.master_tags
}

# Instance cho worker nodes
resource "google_compute_instance" "k8s_worker" {
  count        = var.worker_count
  name         = "k8s-worker-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network       = var.network
    subnetwork    = var.subnetwork
    subnetwork_project = var.project
    network_ip    = var.worker_ips[count.index]
    access_config {}
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Tạo user k8s-admin
    useradd -m -s /bin/bash k8s-admin
    echo "k8s-admin:admin" | chpasswd
    usermod -aG sudo k8s-admin
    echo "k8s-admin ALL=(ALL) ALL" >> /etc/sudoers.d/k8s-admin
    chmod 0440 /etc/sudoers.d/k8s-admin
  EOT
  
  tags = var.worker_tags
}
