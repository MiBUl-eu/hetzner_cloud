module "hcloud_deploy" {
  source = "./terraform_module"

  hcloud_token = var.hcloud_token
}

variable "hcloud_token" {
  sensitive   = true
  description = "Token for HCloud. Use Env Variable Recommended"
}
