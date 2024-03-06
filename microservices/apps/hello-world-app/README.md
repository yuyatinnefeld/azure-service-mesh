# Azure Container Registry

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