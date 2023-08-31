resource "hcloud_server" "web1" {
  name        = "web1"
  server_type = var.server_type
  image       = var.image
  datacenter  = var.datacenter

  ssh_keys    = [ 
    hcloud_ssh_key.own_pubkey.id, 
    hcloud_ssh_key.doku_pubkey.id
  ]

  network {
    network_id = hcloud_network.internal.id
    ip         = "10.0.0.2"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
}

resource "hcloud_server" "web2" {
  name        = "web2"
  server_type = var.server_type
  image       = var.image
  datacenter  = var.datacenter

  ssh_keys    = [ 
    hcloud_ssh_key.own_pubkey.id, 
    hcloud_ssh_key.doku_pubkey.id
  ]

  network {
    network_id = hcloud_network.internal.id
    ip         = "10.0.0.3"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
}

resource "hcloud_server" "web3" {
  name        = "web3"
  server_type = var.server_type
  image       = var.image
  datacenter  = var.datacenter

  ssh_keys    = [ 
    hcloud_ssh_key.own_pubkey.id, 
    hcloud_ssh_key.doku_pubkey.id
  ]

  network {
    network_id = hcloud_network.internal.id
    ip         = "10.0.0.4"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
}

resource "hcloud_server" "lb" {
  name        = "LB"
  server_type = var.server_type
  image       = var.image
  datacenter  = var.datacenter

  ssh_keys    = [ 
    hcloud_ssh_key.own_pubkey.id, 
    hcloud_ssh_key.doku_pubkey.id
  ]

  network {
    network_id = hcloud_network.internal.id
    ip         = "10.0.0.5"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet,
    hcloud_firewall.lbfirewall
  ]

  firewall_ids = [
    hcloud_firewall.lbfirewall.id
  ]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
}
