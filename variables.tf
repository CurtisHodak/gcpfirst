variable "worker_pool_config" {
  type        = string
  default     = ""
  description = "description"
}

variable "worker_pool_private_key" {
  type        = string
  default     = ""
  description = "description"
}

variable "locations" {
  type        = list(string)
  default     = ["us-central1"]
  description = "List of locations for the worker pool"
}