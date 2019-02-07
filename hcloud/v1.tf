locals {
  fqdn = "v1.justaddco.de"
}

# Render a part using a `template_file`
data "template_file" "script" {
  template = "${file("./cloud-config.yml")}"

  vars {
    fqdn = "${local.fqdn}"
  }
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${file("./cloud-init/apt-configure-dokku.sh")}"
  }

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.script.rendered}"
  }

}

# Create a new server running debian
resource "hcloud_server" "v1_justaddco_de" {
  location = "fsn1"
  name = "${local.fqdn}"
  image = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys = ["${hcloud_ssh_key.default.id}"]
  user_data = "${data.template_cloudinit_config.config.rendered}"
}

output "v1.justaddco.de" {
  value = "${hcloud_server.v1_justaddco_de.ipv4_address}"
}
