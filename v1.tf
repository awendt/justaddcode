# Render a part using a `template_file`
data "template_file" "script" {
  template = file("./cloud-config.yml")

  vars = {
    fqdn = "v1.${var.hostname}"
  }
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("./cloud-init/dokku-config.sh")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("./cloud-init/secrets.sh")
  }
}

# Create a new server running debian
resource "hcloud_server" "v1_justaddco_de" {
  location    = "fsn1"
  name        = "v1.${var.hostname}"
  image       = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = data.template_cloudinit_config.config.rendered
}

output "v1_ip_address" {
  value = hcloud_server.v1_justaddco_de.ipv4_address
}
