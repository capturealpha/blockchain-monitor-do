resource "digitalocean_ssh_key" "default" {
  name       = var.monitor_droplet_name
  public_key = file(var.public_key_path)
}