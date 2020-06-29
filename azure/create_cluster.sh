#!/usr/bin/env bash

# PARAMETERS: 1 - RESOURCE_GROUP_NAME, 2 - LOCATION, 3 - CLUSTER_NAME, 4 - AZURE_STORAGE_ACCOUNT, 5 - HTTP_CREDENTIAL

#RESOURCE_GROUP_NAME=mygroupgridu
RESOURCE_GROUP_NAME=$1
#LOCATION=eastus
LOCATION=$2
#CLUSTER_NAME=my-cluster-gridu
CLUSTER_NAME=$3
#AZURE_STORAGE_ACCOUNT=mystorageaccountgridu
AZURE_STORAGE_ACCOUNT=$4
HTTP_CREDENTIAL=$5
SSH_CREDENTIALS=$HTTP_CREDENTIAL

AZURE_STORAGE_CONTAINER=${CLUSTER_NAME}
CLUSTER_SIZE_IN_NODES=1
CLUSTER_VERSION=3.6
CLUSTER_TYPE=spark
COMPONENT_VERSION=Spark=2.3

if [[ -z "${RESOURCE_GROUP_NAME}" ]]; then
  echo "Variable RESOURCE_GROUP_NAME should be set"
  exit 1
fi

if [[ -z "${LOCATION}" ]]; then
  echo "Variable LOCATION should be set"
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
if [[ -z "${HTTP_CREDENTIAL}" ]]; then
  echo "Variable HTTP_CREDENTIAL should be set"
  exit 1
fi

az group create \
    --location ${LOCATION} \
    --name ${RESOURCE_GROUP_NAME}

az storage account create \
    --name ${AZURE_STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --https-only true \
    --kind StorageV2 \
    --location ${LOCATION} \
    --sku Standard_LRS

export AZURE_STORAGE_KEY=$(az storage account keys list \
    --account-name ${AZURE_STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --query [0].value -o tsv)

az storage container create \
    --name ${AZURE_STORAGE_CONTAINER} \
    --account-key ${AZURE_STORAGE_KEY} \
    --account-name ${AZURE_STORAGE_ACCOUNT}

az hdinsight create \
    --name ${CLUSTER_NAME} \
    --resource-group ${RESOURCE_GROUP_NAME} \
    --type ${CLUSTER_TYPE} \
    --component-version ${COMPONENT_VERSION} \
    --http-password ${HTTP_CREDENTIAL} \
    --http-user admin \
    --location ${LOCATION} \
    --workernode-count ${CLUSTER_SIZE_IN_NODES} \
    --ssh-password ${SSH_CREDENTIALS} \
    --ssh-user sshuser \
    --storage-account ${AZURE_STORAGE_ACCOUNT} \
    --storage-account-key ${AZURE_STORAGE_KEY} \
    --storage-container ${AZURE_STORAGE_CONTAINER} \
    --version ${CLUSTER_VERSION}


queueName=my-queue

az storage queue create --name ${queueName}  \
    --account-key ${AZURE_STORAGE_KEY} \
    --account-name ${AZURE_STORAGE_ACCOUNT}

az storage queue exists -n ${queueName} \
    --account-key ${AZURE_STORAGE_KEY} \
    --account-name ${AZURE_STORAGE_ACCOUNT}
