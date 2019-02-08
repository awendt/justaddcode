ifndef HOSTNAME
$(error HOSTNAME is not set, please re-run with `make HOSTNAME=tld.example.com`)
endif

build: .terraform
	terraform apply -var="hostname=$(HOSTNAME)"

.terraform: shared.tf
	terraform init
