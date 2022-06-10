mkdir -p data

docker kill fc-controller > /dev/null 2>&1
docker rm fc-controller > /dev/null 2>&1
docker pull featurecloud.ai/controller

# Only needed to speed up the download later
docker pull featurecloud.ai/fc_cross_validation
docker pull featurecloud.ai/basic_normalization
docker pull featurecloud.ai/fc_logistic_regression
docker pull featurecloud.ai/fc_roc

docker run \
 -d \
 -p 8000:8000 \
 --name fc-controller \
 -v "/var/run/docker.sock:/var/run/docker.sock" \
 --mount "type=bind,source=$(pwd)/data,target=/data" \
 featurecloud.ai/controller "--host-root=$(pwd)/data" "--internal-root=/data" "--controller-name=fc-controller"
