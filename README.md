# Azure Service Mesh Project

## Overview 
This project serves as a learning platform for understanding microservices architecture and service mesh implementation, particularly within the Azure ecosystem.

## Technology Stack
- Cloud Provider: Azure
- Infrastructure as Code (IaC): Terraform
- Continuous Integration and Continuous Deployment (CI/CD): GitLab
- Service Mesh: Istio

## Setup Steps

### 1. Create a Service Principal

To create a service principal in Azure using Azure CLI, follow these steps:
```bash
# List all service principals
az ad sp list --query "[].{displayName:displayName, appId:appId, objectId:objectId}"

# Create a Resource Group
RESOURCE_GROUP="storage-resource-group"
LOCATION=germanywestcentral

az group create --name $RESOURCE_GROUP --location $LOCATION

# Create a new service principals
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME

# Give owner role to the service principal
az role assignment create --assignee $AZURE_APP_ID --role "Owner" --scope /subscriptions/$SUBSCRIPTION_ID
```

### 2. Define GitLab CI/CD Variables
Create the following variables in GitLab CI/CD settings:
- AZURE_APP_ID
- AZURE_PASSWORD
- AZURE_TENANT

### Terraform Integration
- IAM: Set up Microsoft Entra tenant for Terraform user.
- Bucket: Create an Azure Storage Account for Statefile.
- Docker Private Repo: Configure Azure Container Registry.
- Kubernetes Cluster: Deploy an Azure Kubernetes Service (AKS) cluster.

## Clean up
Execute the following commands to clean up resources:

```bash
# Delete the service principal
az ad sp delete --id $AZURE_APP_ID

# Delete the resource group
az group delete --name $RESOURCE_GROUP

# Delete the storage account
az storage account delete --name $AZURE_STATE_FILE_STORAGE --resource-group $AZURE_RESOURCE_GROUP
```