SHELL := /bin/bash

setup:
	./scripts/setup.sh

init:
	cd tf; terraform init

plan:
	cd tf; terraform plan -var subscription_id="${SUBSCRIPTION_ID}" \
		-var client_id="${SERVICE_PRINCIPAL}" \
    -var client_secret="${SERVICE_PRINCIPAL_SECRET}" \
    -var tenant_id="${TENANT_ID}" \
	  -var ssh_key="${AKS_SSH_PUB_KEY}" \
		-out tfplan

apply:
	cd tf; terraform apply tfplan

kube-config:
	az aks get-credentials -n aks-test-app -g aks-test-app

kube-services:
	kubectl get svc

kube-deployments:
	kubectl get deploy -o wide
