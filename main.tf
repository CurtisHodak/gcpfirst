# resource "google_storage_bucket" "cheap_bucket" {
#   name                        = "curtis-cheap-demo-${random_id.suffix.hex}"
#   location                    = "US-CENTRAL1"   # free-tier eligible; keep Standard storage
#   storage_class               = "STANDARD"
#   uniform_bucket_level_access = true

#   # Prevent accidental public access
#   public_access_prevention = "enforced"

#   # Auto-clean to avoid surprises
#   lifecycle_rule {
#     condition { age = 30 }   # delete objects older than 30 days
#     action    { type = "Delete" }
#   }

#   force_destroy = true  # allows terraform destroy even if objects exist
# }

# resource "random_id" "suffix" {
#   byte_length = 3
# }

# module "my_workerpool" {
#   source = "github.com/spacelift-io/terraform-google-spacelift-workerpool?ref=v1.2.0"

#   configuration = <<-EOT
#     export SPACELIFT_TOKEN="${var.worker_pool_config}"
#     export SPACELIFT_POOL_PRIVATE_KEY="${var.worker_pool_private_key}"
#   EOT

#   image   = "projects/spacelift-workers/global/images/spacelift-worker-us-1634112379-tmoys2fp"
#   network = "default"
#   region  = "us-central1"
#   zone    = "us-central1-a"
#   size    = 2
#   email   = "spacelift-oidc-test@curtisgcpproject.iam.gserviceaccount.com"
  
#   providers = {
#     google = google
#   }

#     depends_on = [
#     google_compute_router_nat.nat
#   ]
# }


# # Cloud Router (control plane for NAT)
# resource "google_compute_router" "nat_router" {
#   name    = "spacelift-nat-router"
#   network = "default"              # or your custom VPC
#   region  = "us-central1"
# }

# # Cloud NAT (egress to Internet for private instances)
# resource "google_compute_router_nat" "nat" {
#   name                               = "spacelift-nat"
#   router                             = google_compute_router.nat_router.name
#   region                             = google_compute_router.nat_router.region
#   nat_ip_allocate_option             = "AUTO_ONLY"   # auto-assign public IPs to the NAT gateway
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

#   log_config {
#     enable = true
#     filter = "ERRORS_ONLY"
#   }
# }

# resource "google_bigquery_dataset" "example" {
#   dataset_id = "policytest_dataset"
#   location   = "us-central1"

#   access {
#     role       = "roles/bigquery.dataViewer"
#     iam_member = "serviceAccount:spacelift-oidc-test@curtisgcpproject.iam.gserviceaccount.com"
#   }

#   access {
#     role       = "roles/bigquery.dataOwner"
#     iam_member = "serviceAccount:spacelift-oidc-test@curtisgcpproject.iam.gserviceaccount.com"
#   }

#   access {
#     role       = "OWNER"
#     iam_member = "serviceAccount:spacelift-oidc-test@curtisgcpproject.iam.gserviceaccount.com"
#   }
# }

# # changes