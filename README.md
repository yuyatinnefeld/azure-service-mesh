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

### 1. Create a Service Principal for Terraform user

To create a service principal in Azure using Azure CLI, follow these steps:
```bash
# Check Tenant Info (GCP Organization Info)
az account tenant list

# Chekc Subscription Info (GCP Project Info)
subscriptionId="$(az account list --query "[?isDefault].id" --output tsv)"
echo $subscriptionId

# List all service principals
az ad sp list --query "[].{displayName:displayName, appId:appId, objectId:objectId}"

# Create a new service principals
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME

# Give owner role to the service principal
az role assignment create --assignee $AZURE_APP_ID_DEV --role "Owner" --scope /subscriptions/$SUBSCRIPTION_ID
```

### 2. Define GitLab CI/CD Variables
Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
- AZURE_APP_ID_DEV
- AZURE_SERVICE_PRINCIPAL_PASSWORD_DEV
- AZURE_SUBSCRIPTION_ID_DEV
- AZURE_TENANT_DEV

### 3. Authenticating to Azure using a Service Principal and a Client Secret 

Guide: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

1. Creating an Application in Azure Active Directory

2. Assigning the Client Certificate to the Azure Active Directory Application

3. Allowing the Service Principal to manage the Subscription

###### Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
AZURE_CLIENT_ID_DEV
AZURE_CLIENT_SECRET

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

