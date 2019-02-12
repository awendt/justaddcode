build: .terraform cloud-init/secrets.sh terraform.tfvars
ifndef HOSTNAME
	$(error HOSTNAME is not set, please re-run with `make HOSTNAME=tld.example.com`)
endif

	terraform apply -var="hostname=$(HOSTNAME)"

.terraform: shared.tf
	terraform init

terraform.tfvars:
	@read -s -p "Your Hetzner Cloud API token: " token; \
	echo hcloud_token = \"$$token\" > terraform.tfvars

cloud-init/secrets.sh:
	touch cloud-init/secrets.sh
