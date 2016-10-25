# Dockerfile for https://index.docker.io/u/welcheb/dicom_tools/
FROM ubuntu:14.04

MAINTAINER E. Brian Welch <brian.welch@vanderbilt.edu>

RUN apt-get -y update && apt-get install -y \
  wget \
  unzip \
  build-essential \
  xutils-dev \
  default-jre

# dicom3tools
# http://www.dclunie.com/dicom3tools
RUN wget http://www.dclunie.com/dicom3tools/workinprogress/dicom3tools_1.00.snapshot.20160721064406.tar.bz2
RUN tar xvjf dicom3tools_1.00.snapshot.20160721064406.tar.bz2
WORKDIR "/dicom3tools_1.00.snapshot.20160721064406"
RUN ./Configure
RUN imake -I./config
RUN make World
RUN make install
RUN make clean

# DCMTK (Offis DICOM Toolkit)
# http://dcmtk.org/dcmtk.php.en
RUN apt-get install -y dcmtk

# change to top level directory
WORKDIR "/"

# dcm4che2
# https://sourceforge.net/projects/dcm4che/files/dcm4che2/
RUN wget -O dcm4che-2.0.29-bin.zip http://downloads.sourceforge.net/project/dcm4che/dcm4che2/2.0.29/dcm4che-2.0.29-bin.zip
RUN unzip dcm4che-2.0.29-bin.zip

# dcm4che3
# https://sourceforge.net/projects/dcm4che/files/dcm4che3/
RUN wget -O dcm4che-3.3.7-bin.zip http://downloads.sourceforge.net/project/dcm4che/dcm4che3/3.3.7/dcm4che-3.3.7-bin.zip
RUN unzip dcm4che-3.3.7-bin.zip

# scratch directory for volume mount
RUN mkdir /scratch && echo "This is the dicom_tools scratch folder" > /scratch/scratch.txt
WORKDIR "/scratch"

# cleanup
RUN apt-get purge -y build-essential xutils-dev
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# take care of path
ENV PATH /dcm4che-3.3.7/bin:/dcm4che-2.0.29/bin:$PATH

# array form of entrypoint to support additional argument from docker run command
ENTRYPOINT ["/bin/bash"]
