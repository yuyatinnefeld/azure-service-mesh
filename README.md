# Azure Service Mesh Project

## Overview 
This project serves as a learning platform for understanding microservices architecture and service mesh implementation, particularly within the Azure ecosystem.

## Technology Stack
- Cloud Provider: Azure
- Infrastructure as Code (IaC): Terraform
- Continuous Integration and Continuous Deployment (CI/CD): GitLab
- Service Mesh: Istio

### Terraform Integration
- IAM: Set up Microsoft Entra tenant for Terraform user.
- Bucket: Create an Azure Storage Account for Statefile.
- Docker Private Repo: Configure Azure Container Registry.
- Kubernetes Cluster: Deploy an Azure Kubernetes Service (AKS) cluster.

## Setup Steps

### 0. Create Azure Account

### 1. Create a Service Principal for Terraform user

To create a service principal in Azure using Azure CLI, follow these steps:
```bash
# Check Tenant ID (GCP => Organization)
az account tenant list

# Chekc Subscription ID (GCP => Project)
SUBSCRIPTION_ID="$(az account list --query "[?isDefault].id" --output tsv)"
echo $SUBSCRIPTION_ID

# List all service principals
az ad sp list --query "[].{displayName:displayName, appId:appId, objectId:objectId}"

# Create a new service principals and give owner role within the subscription
SERVICE_PRINCIPAL_NAME=yuyatinnefeld-dev-admin
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME
AZURE_APP_ID_DEV="f99941a5-f7c3-4445-bc7c-45adb2b2c019"
az role assignment create --assignee $AZURE_APP_ID_DEV --role "Owner" --scope /subscriptions/$SUBSCRIPTION_ID
```

### 2. Define GitLab CI/CD Variables
Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
- AZURE_APP_ID_DEV
- AZURE_SERVICE_PRINCIPAL_PASSWORD_DEV
- AZURE_SUBSCRIPTION_ID_DEV
- AZURE_TENANT_DEV

### 3. Authenticating to Azure using a Service Principal and a Client Secret 

Guide: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#1-creating-an-application-in-azure-active-directory

1. Creating an Application in Azure Active Directory
```bash
App-Name: Terraform-Application
Supported-account-types: Default Directory only - Single tenant
```
2. Generating a Client Secret for the Azure Active Directory Application

3. Allowing the Service Principal to manage the Subscription

###### Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
AZURE_CLIENT_ID_DEV (Application / Client ID)
AZURE_CLIENT_SECRET (Value of the Client Secret)

4. Create a branch 'initial' and push the changes.


### 4. Setup Container Registry
1. Activate Admin User

```bash
az acr update -n $AZURE_CONTAINER_REGISTRY_NAME --admin-enabled true
```

### 5. Setup AKS Cluster
```bash
# Connect to the cluster
az aks get-credentials --resource-group container-registry-resources --name myAKSCluster
```

## Clean up
Execute the following commands to clean up resources:

```bash
# Delete the service principal
az ad sp delete --id $AZURE_APP_ID

# Delete the storage account
az storage account delete --name $AZURE_STATE_FILE_STORAGE_DEV --resource-group $azure_storage_resource_group_DEV

# Delete the resource group
az group delete --name $azure_storage_resource_group

# Delete the terraform resources
terraform destroy -var-file=env/dev.tfvars
```

