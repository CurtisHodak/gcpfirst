resource "google_storage_bucket" "cheap_bucket" {
  name                        = "curtis-cheap-demo-${random_id.suffix.hex}"
  location                    = "US-CENTRAL1"   # free-tier eligible; keep Standard storage
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  # Prevent accidental public access
  public_access_prevention = "enforced"

  # Auto-clean to avoid surprises
  lifecycle_rule {
    condition { age = 30 }   # delete objects older than 30 days
    action    { type = "Delete" }
  }

  force_destroy = true  # allows terraform destroy even if objects exist
}

resource "random_id" "suffix" {
  byte_length = 3
}
