# Cloudflare DNS 
data "cloudflare_zone" "default" {
  name = var.root_domain
}
resource "cloudflare_record" "default" {
  name    = "${var.prefix}-do.${var.root_domain}"
  value   = digitalocean_droplet.monitor.ipv4_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}