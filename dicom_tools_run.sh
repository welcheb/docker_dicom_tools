#!/bin/bash

# present working directory
DIR=`pwd`

# run dicom_tools docker container
# volume mount connects scratch directory on container to the present working directory on host
# the --rm option causes the container created to run the image to be automatically removed upon exit
# the -v maps a volume between the host and the container
# the -c passes the command arguments to execute
docker run --rm -v "$DIR":/scratch welcheb/dicom_tools -c "$*"
