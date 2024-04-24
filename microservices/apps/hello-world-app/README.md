# Azure Container Registry

## Debug - Pull/Push into the ACR


```bash
DOCKER_REGISTRY_REPO_NAME=yuyatinnefeld
IMAGE_NAME=hello-world:1.2.0

# build and check
docker build -t $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME .
docker run -d --rm -e MESSAGE="MY_MESSAGE_ABCD" -p 8080:8080 $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME
curl localhost:8080

# test push
docker image push $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME

# clean up
docker system prune --all

# test pull
docker run -d --rm -e MESSAGE="MY_MESSAGE_ABCD" -p 8080:8080 $DOCKER_REGISTRY_REPO_NAME/$IMAGE_NAME

# test with k8s
cd microservices/deployment
kubectl apply -f hello-world-app.yaml
kubectl port-forward svc/hello-world-service 8080 &

```


## Debug - Pull/Push into the ACR

```bash
AZURE_CONTAINER_REGISTRY_REPO_NAME=yuyatinnefeldcontainerregistrydev.azurecr.io
IMAGE_NAME=hello-world:latest
AZURE_CONTAINER_REGISTRY_NAME=yuyatinnefeldContainerRegistryDev
AZURE_CONTAINER_REGISTRY_USER_PWD=xxxx

docker build -t $AZURE_CONTAINER_REGISTRY_REPO_NAME/$IMAGE_NAME .
docker run -p 8888:8888 -t $AZURE_CONTAINER_REGISTRY_REPO_NAME/$IMAGE_NAME
docker tag hello-world $AZURE_CONTAINER_REGISTRY_REPO_NAME/$IMAGE_NAME
docker login $AZURE_CONTAINER_REGISTRY_REPO_NAME -u $AZURE_CONTAINER_REGISTRY_NAME -p $AZURE_CONTAINER_REGISTRY_USER_PWD

# test push
docker push $AZURE_CONTAINER_REGISTRY_REPO_NAME/$IMAGE_NAME

# clean up
docker system prune --all

# test pull
docker run -it --rm -p 8888:8888 $AZURE_CONTAINER_REGISTRY_REPO_NAME/$IMAGE_NAME
```