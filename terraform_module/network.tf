resource "hcloud_network" "internal" {
  name       = "internal"
  ip_range   = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "server"
  network_id   = hcloud_network.internal.id
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}

//resource "hcloud_primary_ip" "lb_ip" {
//  name          = "lb_ip"
//  datacenter    = "nbg1-dc3"
//  type          = "ipv4"
//  assignee_type = "server"
//  auto_delete   = true
//  ip_address    = "162.55.152.87"
//}

data "hcloud_primary_ip" "lb_ip" {
  ip_address = "162.55.152.87"
}

//data "hcloud_floating_ip" "lb_ip" {
//  ip_address = "162.55.152.87"
//}

//resource "hcloud_floating_ip" "lb_ip" {
//  type      = "ipv4"
//  server_id = hcloud_server.lb.id
//}

