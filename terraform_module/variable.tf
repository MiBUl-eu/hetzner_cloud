variable "hcloud_token" {
  sensitive   = true
  description = "Token for HCloud. Use Env Variable Recommended"
}

variable "server_type" {
  type        = string
  description = "Server Type for Deployment"
  default     = "cx21"
}

variable "image" {
  type        = string
  description = "Image for Deployment"
  default     = "ubuntu-22.04"
}

variable "datacenter" {
  type        = string
  description = "Datacenter to Deploy in"
  default     = "nbg1-dc3"
}
