IMAGE=harbor.cloud.infn.it/datacloud-templates/jaas_user_containers:1.3.0-2
docker build -f jaas_user_containers.Dockerfile \
             -t $IMAGE .
docker push $IMAGE
