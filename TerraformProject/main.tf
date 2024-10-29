# Cấu hình lưu trữ trạng thái trên GCS
terraform {
  backend "gcs" {
    bucket      = "k8s_bucket_group10_nt531"            # Tên bucket trên GCS
    prefix      = "terraform/state"                     # Đường dẫn lưu trữ trạng thái
    credentials = "D:/Study/key/norse-case-439506-h4-783c3e3d6177.json"  # Đường dẫn đến tệp JSON xác thực
  }
}
# Gọi module google_provider để cấu hình provider Google Cloud
module "google_provider" {
  source      = "./modules/provider"
  credentials = "D:/Study/key/norse-case-439506-h4-783c3e3d6177.json"
  project     = var.project
  region      = "us-central1"
}
# Gọi module address để tạo các địa chỉ IP tĩnh cho master và worker nodes
module "address" {
  source       = "./modules/address"
  region       = "us-central1"
  project     = var.project
  master_name  = "k8s-master-ip"
  worker_name  = "k8s-worker-ip"
  worker_count = 3
}
# Gọi module instance để tạo các instance cho master và worker nodes
module "instance" {
  source               = "./modules/instance"
  project     = var.project
  machine_type         = "e2-medium"
  zone                 = "us-central1-a"
  image                = "ubuntu-2204-jammy-v20240927"
  network              = "default"
  subnetwork           = "default"
  master_ip            = module.address.master_ip
  worker_ips           = module.address.worker_ips
  ssh_keys             = "k8s-admin:${file("D:/Study/id_rsa.pub")}"
  master_tags = ["k8s", "ssh"]
  worker_tags = ["k8s", "ssh", "worker"]
}
# Gọi module firewall để thiết lập các firewall rule
module "firewall" {
  source                   = "./modules/firewall"
  project     = var.project
  network                  = "default"
  ssh_source_ranges        = ["0.0.0.0/0"]
  ssh_target_tags          = ["ssh"]
  http_https_source_ranges = ["0.0.0.0/0"]
  http_https_target_tags   = ["k8s"]
  worker_source_ranges     = ["0.0.0.0/0"]
  worker_target_tags       = ["worker"]
}
# Gọi module load_balancer để thiết lập cấu hình load balancer, health checks, và SSL
module "load_balancer" {
  source         = "./modules/load_balancer"
  project     = var.project
  http_port      = 30080
  https_port     = 30443
  zone           = "us-central1-a"
  domains        = ["nt531.com"]
  instance_group = module.instance.worker_instance_self_links
}