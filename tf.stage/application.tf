# startup script 
resource "local_file" "start" {
  content = templatefile("${path.module}/start.tpl", {
    mybucket = data.google_storage_bucket.techplace.name
  })

  filename = "./start.sh"
}

# instance template
resource "google_compute_instance_template" "stage" {
  name        = "runner-stage"
  description = "This template is used to create gitlab runner server instances."

  machine_type = "e2-medium"
  tags         = ["stage-runner"]
  project      = var.project

  labels = {
    terraform = true,
    project   = "skillbox",
    type      = "stage",
    owner     = "${local.name}_${local.surname}"
  }
  scheduling {
    preemptible                 = true
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
    automatic_restart           = false
  }
  disk {
    source_image = "debian-cloud/debian-11"
    disk_name    = "persistent-disk-stage"
    device_name  = "persistent-disk-stage"
  }

  service_account {
    email  = local.sa
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "PREMIUM"
    }
  }

  lifecycle {
    ignore_changes = [network_interface]
  }

  metadata_startup_script = local_file.start.content
  depends_on              = [local_file.start]
}

# # reserved IP address
# resource "google_compute_global_address" "default" {
#   project = var.project
#   name    = "static-ip"
# }

# # health check
# resource "google_compute_health_check" "ssh" {
#   project             = var.project
#   name                = "autohealing-ssh-check"
#   check_interval_sec  = 5
#   timeout_sec         = 5
#   healthy_threshold   = 2
#   unhealthy_threshold = 10 # 50 seconds

#   tcp_health_check {
#     port = "22"
#   }
# }

resource "google_compute_region_instance_group_manager" "stage02" {
  project            = var.project
  name               = "stage02"
  base_instance_name = "stage02"
  target_size        = 1
  region             = "us-central1"

  distribution_policy_zones = [
    "us-central1-a",
    "us-central1-b",
    "us-central1-c",
  ]

  version {
    instance_template = google_compute_instance_template.stage.id
  }

  stateful_disk {
    delete_rule = "ON_PERMANENT_INSTANCE_DELETION"
    device_name = "persistent-disk-stage"
  }

  auto_healing_policies {
    health_check      = data.google_compute_health_check.ssh.id
    initial_delay_sec = 300
  }
  update_policy {
    type                         = "OPPORTUNISTIC"
    minimal_action               = "REPLACE"
    instance_redistribution_type = "NONE"
    max_surge_fixed              = 3
    max_unavailable_fixed        = 3
  }
}

# # backend service
# resource "google_compute_backend_service" "default" {
#   name                  = "backend-service"
#   project               = var.project
#   protocol              = "HTTP"
#   timeout_sec           = 10
#   enable_cdn            = true
#   load_balancing_scheme = "EXTERNAL"
#   port_name             = "http"
#   health_checks         = [google_compute_health_check.autohealing.id]

#   backend {
#     group = google_compute_region_instance_group_manager.appserver[0].instance_group
#   }

#   backend {
#     group = google_compute_region_instance_group_manager.appserver[1].instance_group
#   }
# }

# # url map
# resource "google_compute_url_map" "default" {
#   name            = "tf-url-map"
#   project         = var.project
#   default_service = google_compute_backend_service.default.id
# }

# # http proxy
# resource "google_compute_target_http_proxy" "default" {
#   name    = "tf-http-proxy"
#   project = var.project
#   url_map = google_compute_url_map.default.id
# }

# # forwarding rule
# resource "google_compute_global_forwarding_rule" "default" {
#   name                  = "ft-forwarding-rule"
#   project               = var.project
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL"
#   port_range            = "80"
#   target                = google_compute_target_http_proxy.default.id
#   ip_address            = google_compute_global_address.default.id
# }
