# build docker image using Dockerfile in current folder
USER="welcheb"
REPO="dicom_tools"
TAG="$USER/$REPO"
docker build -t=$TAG .

# save a flattened (squashed) tar.gz
CONTAINER_ID=`docker create $TAG`
docker export $CONTAINER_ID | gzip -9 > ./docker_save/$REPO.tar.gz
docker rm $CONTAINER_ID

# remove image before replacing it with flattened version
docker rmi -f $TAG

# import from flattened image
docker import ./docker_save/$REPO.tar.gz $TAG:latest
