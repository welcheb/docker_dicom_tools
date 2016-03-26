# build docker image using Dockerfile in current folder
USER="welcheb"
REPO="dicom_tools"
TAG="$USER/$REPO"
docker build -t=$TAG .

# save a flattened (squashed) tar.gz
CONTAINER_ID=`docker create $TAG`
docker export $CONTAINER_ID | gzip -9 > ./docker_save/$REPO.tar.gz
docker rm $CONTAINER_ID

# load from flattened image
docker load < ./docker_save/$REPO.tar.gz
