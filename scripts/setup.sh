#!/bin/bash
SSH_KEY=~/.ssh/id_rsa_aks.pub
CONFIG_FILE=~/.config/azure-practice-vars

if [[ ! -f $SSH_KEY ]]
then
  echo You need to generate an ssh key $SSH_KEY
  exit 1
fi

if [[ -f $CONFIG_FILE ]]
then
  echo Already configured. Activate using:
  echo . $CONFIG_FILE
  exit 0
fi

acc=$(az account list)
JSON=$(az ad sp create-for-rbac --skip-assignment --name aks-test-app -o json)

cat << END > $CONFIG_FILE
export TENANT_ID=$(echo $acc | jq -r ".[].tenantId")
export SUBSCRIPTION_ID=$(echo $acc | jq -r ".[].id")
export SERVICE_PRINCIPAL=$(echo "$JSON" | jq -r ".appId")
export SERVICE_PRINCIPAL_SECRET=$(echo "$JSON" | jq -r ".password")
export AKS_SSH_PUB_KEY="$(cat $SSH_KEY)"
END

. $CONFIG_FILE

az role assignment create --assignee $SERVICE_PRINCIPAL --subscription $SUBSCRIPTION_ID --role Contributor 

