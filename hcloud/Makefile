ifndef HOSTNAME
$(error HOSTNAME is not set, please re-run with `make HOSTNAME=tld.example.com`)
endif

build: .terraform cloud-init/secrets.sh
	terraform apply -var="hostname=$(HOSTNAME)"

.terraform: shared.tf
	terraform init

cloud-init/secrets.sh:
	touch cloud-init/secrets.sh
