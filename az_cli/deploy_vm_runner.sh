#!/bin/bash

RESOURCE_GROUP_NAME=rg_runner
LOCATION=westeurope
VNET_NAME=runner-vnet
ADDRESS_PREFIXES=10.0.0.0/16
SUBNET_NAME=runner-subnet
SUBNET_PREFIXES=10.0.0.0/24
PIP_NAME_00=runner-pip-00
PIP_NAME_01=runner-pip-01
VM_NAME_00=runner-vm-00
VM_NAME_01=runner-vm-01
ADMIN_NAME=pierrc

# create resource group with az cli
echo "Creating resource group..." 
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# create vnet with address prefix 10.0.0.0/16
echo "Creating vnet..."
az network vnet create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $VNET_NAME \
    --address-prefixes $ADDRESS_PREFIXES

# create subnet with address prefix
echo "Creating subnet..."
az network vnet subnet create \
    --resource-group $RESOURCE_GROUP_NAME \
    --vnet-name $VNET_NAME \
    --name $SUBNET_NAME \
    --address-prefixes $SUBNET_PREFIXES

# create public ip address
echo "Creating public ip 00 ..."
az network public-ip create \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --name $PIP_NAME_00 \
    --sku Standard

# create public ip address
echo "Creating public ip 01 ..."
az network public-ip create \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --name $PIP_NAME_01 \
    --sku Standard

# create network security group
echo "Creating network security group..."
az network nsg create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name runner-nsg

# create network security group rule inbound port tcp 22
echo "Creating network security group rule inbound port tcp 22..."
az network nsg rule create \
    --resource-group $RESOURCE_GROUP_NAME \
    --nsg-name runner-nsg \
    --name allow_ssh \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow

# attach network security group to subnet
echo "Attaching network security group to subnet..."
az network vnet subnet update \
    --resource-group $RESOURCE_GROUP_NAME \
    --vnet-name $VNET_NAME \
    --name $SUBNET_NAME \
    --network-security-group runner-nsg

# create network interface
echo "Creating network interface..."
az network nic create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name runner-00-nic \
    --vnet-name $VNET_NAME \
    --subnet $SUBNET_NAME \
    --public-ip-address $PIP_NAME_00

# create network interface
echo "Creating network interface 01 ..."
az network nic create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name runner-01-nic \
    --vnet-name $VNET_NAME \
    --subnet $SUBNET_NAME \
    --public-ip-address $PIP_NAME_01

# create vm linux ubuntu 22.04 LTS with serie b2s with my ssh keys and user pierrc
echo "Creating vm 00 linux ubuntu 22.04 LTS ..."
az vm create \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --name $VM_NAME_00 \
    --image Ubuntu2204 \
    --size Standard_B2s \
    --admin-username $ADMIN_NAME \
    --ssh-key-values ~/.ssh/id_rsa.pub \
    --nics runner-00-nic

# create vm linux ubuntu 22.04 LTS with serie b2s with my ssh keys and user pierrc
echo "Creating vm 01 linux ubuntu 22.04 LTS ..."
az vm create \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $LOCATION \
    --name $VM_NAME_01 \
    --image Ubuntu2204 \
    --size Standard_B2s \
    --admin-username $ADMIN_NAME \
    --ssh-key-values ~/.ssh/id_rsa.pub \
    --nics runner-01-nic