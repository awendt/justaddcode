#############################################
# This is shared config for any server setup
#############################################

# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
variable "hcloud_token" {
}

variable "hostname" {
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token

  version = "~> 1.13.0"
}

provider "template" {
  version = "~> 2.0"
}

# Create a new SSH key
resource "hcloud_ssh_key" "default" {
  name       = "boskoop"
  public_key = file("~/.ssh/id_rsa.pub")
}
