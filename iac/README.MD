# Terraform

## Terraform Integration
- IAM: Set up Microsoft Entra tenant for Terraform user.
- Bucket: Create an Azure Storage Account for Statefile.
- Docker Private Repo: Configure Azure Container Registry.
- Kubernetes Cluster: Deploy an Azure Kubernetes Service (AKS) cluster.

## <a name="cicd-variable"></a> Define GitLab CI/CD Variables
Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
- AZURE_APP_ID_DEV
- AZURE_SERVICE_PRINCIPAL_PASSWORD_DEV
- AZURE_SUBSCRIPTION_ID_DEV
- AZURE_TENANT_DEV

## <a name="configure-service-principal"></a> Configure Terraform Service Principal
Authenticating to Azure using a Service Principal and a Client Secret 

Guide: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

Start up with the chapter "1. Creating an Application in Azure Active Directory"

1. Creating an Application in Azure Active Directory
```bash
App-Name: Terraform-Application
Supported-account-types: Default Directory only - Single tenant
```
2. Generating a Client Secret for the Azure Active Directory Application

3. Granting the Application access to manage resources in your Azure Subscription
Access Control (IAM) > Add > Add role assignmen

4. Run terraform init script in the Azure Cloud Shell
```bash
cd iac
bash 0_tf_run.sh
```

5. Create the following variables in GitLab CI/CD settings as Type=VARIABLE and NOT protected variable:
AZURE_CLIENT_ID_DEV (Application / Client ID)
AZURE_CLIENT_SECRET (Value of the Client Secret)
ARM_ACCESS_KEY

6. Create a branch 'initial' and push the changes.


