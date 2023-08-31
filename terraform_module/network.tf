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

data "hcloud_load_balancer" "lb_1" {
  name = "load-balancer-1"
}

resource "hcloud_load_balancer_target" "load_balancer_target" {
  type             = "server"
  load_balancer_id = data.hcloud_load_balancer.lb_1.id
  server_id        = hcloud_server.lb.id
}

# Already defined
#resource "hcloud_load_balancer_service" "load_balancer_service_http" {
#    load_balancer_id = data.hcloud_load_balancer.lb_1.id
#    protocol         = "http"
#}

resource "hcloud_load_balancer_service" "load_balancer_service_https" {
    load_balancer_id = data.hcloud_load_balancer.lb_1.id
    protocol         = "tcp"
    listen_port      = 443
    destination_port = 443
}

resource "hcloud_load_balancer_service" "load_balancer_service_ssh" {
    load_balancer_id = data.hcloud_load_balancer.lb_1.id
    protocol         = "tcp"
    listen_port      = 22
    destination_port = 22
}

