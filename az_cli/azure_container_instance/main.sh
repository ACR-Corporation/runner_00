#!/bin/bash
RESOURCE_GROUP_RUNNER_NAME=rg_runner
LOCATION=westeurope

RESOURCE_GROUP_ACR_NAME=rg_demo_container
ACR_NAME=peteracr007
IMAGE_NAME=peteracr007.azurecr.io/actions-image
IMAGE_VERSION=0.0.1

CONTAINER_NAME=runner

REPO_NAME=ACR-Corporation/runner_00
TOKEN_GH=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

# create a resource group
echo "Creating resource group $RESOURCE_GROUP_RUNNER_NAME..."
az group create \
   --name $RESOURCE_GROUP_RUNNER_NAME \
   --location $LOCATION

# get the password for the container registry
echo "Getting the password for the container registry $ACR_NAME..."
PWD_ACR=$(az acr credential show --name $ACR_NAME --resource-group $RESOURCE_GROUP_ACR_NAME --query "passwords[0].value" --output tsv)

# create the container instance
echo "Creating the container instance..."
az container create \
    --resource-group $RESOURCE_GROUP_RUNNER_NAME \
    --name $CONTAINER_NAME \
    --registry-username $ACR_NAME \
    --registry-password $PWD_ACR \
    --image $IMAGE_NAME:$IMAGE_VERSION \
    --restart-policy Always \
    --environment-variables REPO=$REPO_NAME TOKEN=$TOKEN_GH


    