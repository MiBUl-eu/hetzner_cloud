resource "hcloud_firewall" "lbfirewall" {
  name = "my-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    source_ips = [
      "10.0.0.0/24"
    ]
    port = "any"
  }

  rule {
    direction = "in"
    protocol  = "udp"
    source_ips = [
      "10.0.0.0/24"
    ]
    port = "any"
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0", #maybe only allow from loadballancer? 
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0", #maybe only allow from loadballancer? 
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0", #maybe only allow from loadballancer? 
      "::/0"
    ]
  }
}