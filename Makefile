SHELL := /bin/bash

setup:
	./scripts/setup.sh
init:
	cd tf; terraform init

plan:
	cd tf; echo terraform plan -var subscription_id="$$SERVICE_PRINCIPAL_SECRET" \
		-var client_id="${SERVICE_PRINCIPAL}" \
    -var client_secret="${TENANT_ID}" \
    -var tenant_id="${SUBSCRIPTION_ID}" \
	  -var ssh_key="${AKS_SSH_PUB_KEY}"
