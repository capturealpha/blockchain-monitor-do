resource "digitalocean_ssh_key" "default" {
  name       = var.droplet_name
  public_key = file(var.public_key_path)
}