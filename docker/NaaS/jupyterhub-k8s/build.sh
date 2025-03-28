export HARBOR_CREDENTIALS='harbor-paas-credentials'
export REGISTRY_FQDN='harbor.cloud.infn.it'
export REPO_NAME='datacloud-templates'
export K8S_JHUB_IMAGE_NAME='jhub-k8s'
export TAG_NAME='4.1.0-v1.0.0'
export IMAGE_NAME="${REGISTRY_FQDN}/${REPO_NAME}/${K8S_JHUB_IMAGE_NAME}:${TAG_NAME}"
export DOCKERFILE_PATH="docker/NaaS/jupyterhub-k8s"
export DOCKER_BUILD_OPTIONS="."
docker build -t $IMAGE_NAME $DOCKER_BUILD_OPTIONS
docker push $IMAGE_NAME