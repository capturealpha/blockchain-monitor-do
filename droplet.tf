resource "digitalocean_droplet" "monitor" {
  image             = var.droplet_image
  name              = var.droplet_name
  region            = var.droplet_region
  size              = var.droplet_size
  graceful_shutdown = true
  monitoring        = true
  backups           = true
  ssh_keys          = [digitalocean_ssh_key.default.fingerprint]
  timeouts {
    create = "30m"
    delete = "10m"
  }
  user_data = templatefile("${abspath(path.root)}/cloud-init.yml", {
    fqdn             = "${var.prefix}-do.${var.root_domain}"
    do_token         = var.do_token
    data_volume_name = var.data_volume_name
    prefix           = var.prefix
    ssh_port         = var.ssh_port
    ssh_key_1        = var.ssh_key_1
    ssh_key_2        = var.ssh_key_2
    caddy_user       = var.caddy_user
    caddy_password   = var.caddy_password
  })
  connection {
    type        = "ssh"
    user        = var.prefix
    port        = var.ssh_port
    host        = self.ipv4_address
    private_key = file(var.private_key_path)
    agent       = false
  }
  provisioner "file" {
    source      = "./monitor"
    destination = "/home/${var.prefix}/"
  }
  provisioner "remote-exec" {
    inline = ["cloud-init status --wait",
      <<EOF
        find ~ -name '*.sh' | xargs chmod +x
        cd node && screen -S init -d -m ./init.sh
        sleep 10
      EOF
    ]
  }
  tags = [var.prefix]
}

resource "digitalocean_volume_attachment" "data" {
  droplet_id = digitalocean_droplet.monitor.id
  volume_id  = digitalocean_volume.data.id
}
