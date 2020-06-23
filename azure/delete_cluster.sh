#!/usr/bin/env bash

# PARAMETERS: 1 - RESOURCE_GROUP_NAME, 2 - CLUSTER_NAME, 3 - AZURE_STORAGE_ACCOUNT

RESOURCE_GROUP_NAME=mygroupgridu
#RESOURCE_GROUP_NAME=$1
CLUSTER_NAME=my-cluster-gridu
#CLUSTER_NAME=$2
AZURE_STORAGE_ACCOUNT=mystorageaccountgridu
#AZURE_STORAGE_ACCOUNT=$3
AZURE_STORAGE_CONTAINER=${CLUSTER_NAME}

if [[ -z "${RESOURCE_GROUP_NAME}" ]]; then
  echo "Variable RESOURCE_GROUP_NAME should be set"
  exit 1
fi

if [[ -z "${CLUSTER_NAME}" ]]; then
  echo "Variable CLUSTER_NAME should be set"
  exit 1
fi
if [[ -z "${AZURE_STORAGE_ACCOUNT}" ]]; then
  echo "Variable AZURE_STORAGE_ACCOUNT should be set"
  exit 1
fi

# Remove cluster
echo "deleting cluster"
az hdinsight delete \
    --name ${CLUSTER_NAME} \
    --resource-group ${RESOURCE_GROUP_NAME}

# Remove storage container
echo "deleting storage container"
az storage container delete \
    --account-name ${AZURE_STORAGE_ACCOUNT} \
    --name ${AZURE_STORAGE_CONTAINER}

# Remove storage account
echo "deleting storage account"
az storage account delete \
    --name ${AZURE_STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP_NAME}

# Remove resource group
echo "deleting resource group"
az group delete \
    --name ${RESOURCE_GROUP_NAME}