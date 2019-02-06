# Create a new server running debian
resource "hcloud_server" "v1_justaddco_de" {
  location = "fsn1"
  name = "v1.justaddco.de"
  image = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys = ["${hcloud_ssh_key.default.id}"]
  user_data = "${file("./cloud-config.yml")}"
}
