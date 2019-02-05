#############################################
# This is shared config for any server setup
#############################################

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "hcloud_token" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"

  version = "~> 1.5"
}

# Create a new SSH key
resource "hcloud_ssh_key" "default" {
  name = "boskoop"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
