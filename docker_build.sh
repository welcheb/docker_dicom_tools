docker build -t="welcheb/dicom_tools" .

docker save "welcheb/dicom_tools" | gzip -9 > ./docker_save/dicom_tools.tar.gz
