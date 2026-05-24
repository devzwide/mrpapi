#!/bin/bash

USER_EMAIL=$1

SUB_ID=$(az account list --query "[?user.name=='$USER_EMAIL'].id | [0]" -o tsv | tr -d '\r')
TENANT_ID=$(az account list --query "[?user.name=='$USER_EMAIL'].tenantId | [0]" -o tsv | tr -d '\r')

echo "Setting subscription context for user $USER_EMAIL"
az account set --subscription "$SUB_ID"
az account show

echo "This script will create a service principal with Contributor role for the subscription."
read -p "Continue? (Y/N) " CONFIRM

echo "Creating service principal with Contributor role"
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Creating service principal..."
  SP_OUTPUT=$(az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SUB_ID" --output json)
  
  CLIENT_ID=$(echo "$SP_OUTPUT" | jq -r .appId)
  CLIENT_SECRET=$(echo "$SP_OUTPUT" | jq -r .password)
  
  echo ""
  echo "========================================"
  echo "SERVICE PRINCIPAL SECRETS GENERATED"
  echo "Tenant ID:       $TENANT_ID"
  echo "Subscription ID: $SUB_ID"
  echo "Client ID:       $CLIENT_ID"
  echo "Client Secret:   $CLIENT_SECRET"
  echo "========================================"
  echo "⚠️ COPY THESE VALUES NOW. YOU WILL NEED THEM FOR AZURE DEVOPS."
  echo ""

  az login --service-principal -u "$CLIENT_ID" -p "$CLIENT_SECRET" --tenant "$TENANT_ID"
fi