output "monitor-ip" {
  value = digitalocean_droplet.monitor.ipv4_address
}
output "prefix" {
  value = var.prefix
}