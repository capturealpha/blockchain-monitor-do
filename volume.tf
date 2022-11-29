resource "digitalocean_volume" "data" {
  region                   = var.droplet_region
  name                     = var.data_volume_name
  size                     = var.data_volume_size
  initial_filesystem_type  = var.data_volume_fs_type
  initial_filesystem_label = "${var.prefix}-data"
  description              = "${var.prefix} data volume"
  tags                     = ["${var.prefix}-data"]
}