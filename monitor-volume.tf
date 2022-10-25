resource "digitalocean_volume" "data" {
  region                   = var.monitor_droplet_region
  name                     = var.monitor_data_volume_name
  size                     = var.monitor_data_volume_size
  initial_filesystem_type  = var.monitor_data_volume_fs_type
  initial_filesystem_label = "${var.prefix}-data"
  description              = "${var.prefix} data volume"
  tags                     = ["${var.prefix}-data"]
}