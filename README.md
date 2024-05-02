# Azure Service Mesh Project

## Overview 
This project serves as a learning platform for understanding microservices architecture and service mesh implementation, particularly within the Azure ecosystem.

## Technology Stack
- Cloud Provider: Azure
- Infrastructure as Code (IaC): Terraform
- Continuous Integration and Continuous Deployment (CI/CD): GitLab
- Service Mesh: Istio

## Guideline

### 0. Testing Locally

#### Docker
```bash
DOCKER_REGISTRY_REPO_NAME=yuyatinnefeld
IMAGE_NAME=hello-world:1.5.0
cd microservices/apps/hello-world-app
docker build -t $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME .
docker run -d --rm -e MESSAGE="MY_DOCKER_MESSAGE" -e ENV="DEV" -p 8080:8080 $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME
docker image push $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME
```

#### K8S
```bash
cd microservices/deployment/hello-world-app
kubectl apply -f deployment-dockerhub.yaml
kubectl port-forward svc/hello-world-service 8080 &
```

### 1. Initiate Azure Cloud Project
[Link](azure-cloud/README.md#azure-management-group")

### 2. Create ARG and AKS with az-cli
[Link](azure-cloud/README.md#arg-aks")

### 3. Deploy K8S App into AKS Cluster
[Link](azure-cloud/README.md#aks-deploy")

### 4. Create ACR and Push Image into ARC
[Link](azure-cloud/README.md#acr")

### 5. Create AKS with OSM (Open Service Mesh)
[Link](azure-cloud/README.md#osm")

### 6. Setup Gitlab CICD Workflow and Terraform Integration
- [Create a Terraform Service Principals](azure-cloud/README.md#service-principal")
- [Define GitLab CI/CD Variables](iac/README.MD#cicd-variable")
- [Configurate Terraform Service Principals](iac/README.MD#configure-service-principal")

### 7. Setup Gitops Workflow for AKS Cluster

### 8. Clean Up Resources
Execute the following commands to clean up resources:
```bash
az acr repository delete -n $CONTAINER_REGISTRY_NAME --image $IMAGE_NAME

az aks delete --name $MY_AKS_CLUSTER_NAME --resource-group $MY_RESOURCE_GROUP_NAME

az group delete -n $MY_RESOURCE_GROUP_NAME

az account management-group subscription remove --name $MANAGEMENT_GROUP --subscription $SUBSCRIPTION_NAME
```


