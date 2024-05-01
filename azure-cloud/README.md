# Azure Cloud

## <a name="azure-management-group"></a> Create Azure Management Group
```bash
MANAGEMENT_GROUP=yuyatinnefeldDEV
SUBSCRIPTION_NAME=yuyatinnefeld-dev

az account management-group create --name $MANAGEMENT_GROUP
az account management-group list
az account management-group subscription add --name $MANAGEMENT_GROUP --subscription $SUBSCRIPTION_NAME
```

## <a name="arg-aks"></a> Create Azure Resource Group and AKS Cluster
```bash
# setup env vars
export RANDOM_ID="$(openssl rand -hex 3)"
export MY_RESOURCE_GROUP_NAME="AKSResourceGroup$RANDOM_ID"
export REGION="westeurope"
export MY_AKS_CLUSTER_NAME="AKSCluster$RANDOM_ID"
export MY_DNS_LABEL="dnslabel$RANDOM_ID"

# create resource group
az group create --name $MY_RESOURCE_GROUP_NAME --location $REGION

# create aks cluster
az aks create --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME --enable-managed-identity --node-count 1 --generate-ssh-keys
```

## <a name="aks-deploy"></a> Deploy K8S App into AKS Cluster
```bash
# connect to the cluster
az aks get-credentials --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME

# verify
kubectl get nodes

# deploy
kubectl apply -f deployment-dockerhub.yaml
```

## Test the Application
```bash
export IP_ADDRESS=$(kubectl get service "hello-world-service" --output 'jsonpath={..status.loadBalancer.ingress[0].ip}')

echo "Service IP Address: $IP_ADDRESS"

curl $IP_ADDRESS:8080
```

## <a name="acr"></a> Create ACR and Push Image into ARC
```bash
# setup env vars
export CONTAINER_REGISTRY_NAME="yuyatinnefeldcontainerregistry"
export CONTAINER_REGISTRY_LOGIN_SERVER="yuyatinnefeldcontainerregistry.azurecr.io"

# create container registry
az acr create --resource-group $MY_RESOURCE_GROUP_NAME --name $CONTAINER_REGISTRY_NAME --sku Basic
az acr update -n $CONTAINER_REGISTRY_NAME --admin-enabled true
```

Create Container Registry Admin User
```bash
Container Registry > Access key > Activate Admin User

USER="yuyatinnefeldcontainerregistry"
PWD="xxxxxs"
```

Push Image into ACR (Local Terminal)
```bash
# login
echo "$PWD" | docker login $CONTAINER_REGISTRY_LOGIN_SERVER -u $USER --password-stdin

DOCKER_REGISTRY_REPO_NAME=yuyatinnefeld
IMAGE_NAME=hello-world:1.3.0

# pull image
docker pull $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME

# tag
docker tag $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME $CONTAINER_REGISTRY_LOGIN_SERVER/$IMAGE_NAME

# push
docker push $CONTAINER_REGISTRY_LOGIN_SERVER/$IMAGE_NAME

# verify
az acr repository show --name $CONTAINER_REGISTRY_NAME --repository hello-world
```

Deploy with ACR Image
```bash
kubectl apply -f deployment-acr.yaml
```

## <a name="service-principal"></a> Create a Service Principal

This service principal is used for Terraform tech user

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
AZURE_APP_ID_DEV="f99941a5-f7c3-4445-bc7c-45adb2b2c019"
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME

# Update Role
SERVICE_PRINCIPAL_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [].id --output tsv)
az role assignment create --role "Owner" --assignee-object-id $SERVICE_PRINCIPAL_ID --scope /subscriptions/$SUBSCRIPTION_ID
```