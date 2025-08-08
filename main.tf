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


module "my_workerpool" {
  source = "github.com/spacelift-io/terraform-google-spacelift-workerpool?ref=v1.2.0"

  configuration = <<-EOT
    export SPACELIFT_TOKEN="${var.worker_pool_config}"
    export SPACELIFT_POOL_PRIVATE_KEY="${var.worker_pool_private_key}"
  EOT

  image   = "projects/spacelift-workers/global/images/spacelift-worker-us-1634112379-tmoys2fp"
  network = "default"
  region  = "us-central1"
  zone    = "us-central1-a"
  size    = 2
  email   = "abc@xyz.iam.gserviceaccount.com"
  
  providers = {
    google = google
  }
}