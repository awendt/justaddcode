# Render a multi-part cloud-init config
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
    content      = "${file("./cloud-config.yml")}"
  }

}

# Create a new server running debian
resource "hcloud_server" "v1_justaddco_de" {
  location = "fsn1"
  name = "v1.justaddco.de"
  image = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys = ["${hcloud_ssh_key.default.id}"]
  user_data = "${data.template_cloudinit_config.config.rendered}"
}
