# Deploy Locally
```bash
cd microservices/deployment/hello-world-app
kubectl apply -f local-deployment.yaml
kubectl port-forward svc/hello-world-service 8080 &
```

## Create AKS & ACR & ARG (Azure Shell)
```bash
# setup env vars
export RANDOM_ID="$(openssl rand -hex 3)"
export MY_RESOURCE_GROUP_NAME="AKSResourceGroup$RANDOM_ID"
export REGION="westeurope"
export MY_AKS_CLUSTER_NAME="AKSCluster$RANDOM_ID"
export MY_DNS_LABEL="dnslabel$RANDOM_ID"
export CONTAINER_REGISTRY_NAME="yuyatinnefeldcontainerregistry"
export CONTAINER_REGISTRY_LOGIN_SERVER="yuyatinnefeldcontainerregistry.azurecr.io"

# create resource group
az group create --name $MY_RESOURCE_GROUP_NAME --location $REGION

# create container registry
az acr create --resource-group $MY_RESOURCE_GROUP_NAME --name $CONTAINER_REGISTRY_NAME --sku Basic

# create aks cluster
az aks create --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME --enable-managed-identity --node-count 1 --generate-ssh-keys
```

## Create Container Registry Admin User
```bash
Container Registry > Access key > Activate Admin User

USER="yuyatinnefeldcontainerregistry"
PWD="xxxxxs"
```

## Push Image into ACR (Local Terminal)
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

## Deploy the Application (Azure Shell)
```bash
# connect to the cluster
MY_AKS_CLUSTER_NAME=AKSCluster462b67
MY_RESOURCE_GROUP_NAME=AKSResourceGroup462b67
az aks get-credentials --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME

# verify
kubectl get nodes

# deploy
kubectl apply -f azure-deployment.yaml
```

## Test the Application
```bash
runtime="1 minute"
endtime=$(date -ud "$runtime" +%s)
while [[ $(date -u +%s) -le $endtime ]]
do
   STATUS=$(kubectl get pods -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')
   echo $STATUS
   if [ "$STATUS" == 'True' ]
   then
      export IP_ADDRESS=$(kubectl get service "hello-world-service" --output 'jsonpath={..status.loadBalancer.ingress[0].ip}')
      echo "Service IP Address: $IP_ADDRESS"
      break
   else
      sleep 10
   fi
done

curl $IP_ADDRESS
```

## Clean Up
```bash
az acr repository delete -n $CONTAINER_REGISTRY_NAME --image $IMAGE_NAME

az aks delete --name $MY_AKS_CLUSTER_NAME --resource-group $MY_RESOURCE_GROUP_NAME

az group delete -n $MY_RESOURCE_GROUP_NAME
```
