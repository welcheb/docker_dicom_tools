#!/bin/bash

# present working directory
DIR=`pwd`

# run dicom_tools docker container
# volume mount connects scratch directory on container to the present working directory on host
docker run -v "$DIR":/scratch welcheb/dicom_tools -c "$*"
