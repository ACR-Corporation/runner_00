#!/bin/bash

# Votre code ici


az group create \
  --name rg_runner \
  --location westeurope

az vm create \
  --resource-group rg_runner \
  --name runner \
  --image Ubuntu2204 \
  --admin-username pierrc \
  --admin-password Password123$ \
  --size Standard_B1s \
  --custom-data ./cloud-init.txt \
  --public-ip-address-dns-name runner00