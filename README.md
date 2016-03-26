docker_dicom_tools
==================

Dockerfile to build a Docker image for DICOM tools and utilities. Toolboxes include
[dicom3tools](http://www.dclunie.com/dicom3tools), [dcmtk](http://dcmtk.org/dcmtk.php.en),
[dcm4che2](https://sourceforge.net/projects/dcm4che/files/dcm4che2/), and
[dcm4che3](https://sourceforge.net/projects/dcm4che/files/dcm4che3/).

Overview
========

Docker images and containers (a running image) are similar to virtual machines except that the container operating system (OS) matches the host OS. That allows the container to be managed like a process with no boot-up required. This makes running an application in a container efficient and fast compared to using a virtual machine.

Currently Docker containers run natively on **Linux**. On **Mac OS X** and **Windows**, a lightweight **Linux** virtual machine is required to run the Docker daemon. Docker support for **Mac OS X** and **Windows** is available using the [Docker Toolbox](https://www.docker.com/products/docker-toolbox).

File input/output is handled using shared mounted volumes between the host and the container. Due to limitations of docker volume mounting when the host OS is not **Linux**, the installation of **docker_dicom_tools** is recommended to be under the user's home directory. To process data, the user should change to the directory on the host OS to the directory holding the input data (which should also be under the user home directory) before invoking the `dicom_tools_run.sh` (or `dicom_tools_run.bat` on **Windows**) script.

Getting Started
===============

1. Install [docker](https://www.docker.com).

  **Linux** installation from the command line
  ~~~
  wget -qO- https://get.docker.com | sh
  sudo usermod -aG docker <YOUR_USERNAME>
  reboot
  ~~~

  **Mac OS X** or **Windows**

  Download and install [Docker Toolbox](https://www.docker.com/products/docker-toolbox).

2. Open a command prompt terminal.

  **Linux** : open a normal terminal window

  **Mac OS X** or **Windows** : open **Docker Quickstart Terminal** application

3. Download this git repository to your home directory.

  ~~~
  git clone https://github.com/welcheb/docker_dicom_tools.git ~/docker_dicom_tools
  ~~~

4. Add the path to `dicom_tools_run.sh` to the `PATH` environment variable. Below it is assumed you cloned the git repository into your home directory.

  **Linux**
  ~~~
  echo 'export PATH=$PATH:~/docker_dicom_tools' >> ~/.profile
  source ~/.profile
  ~~~

  **Mac OS X**
  ~~~
  echo 'export PATH=$PATH:~/docker_dicom_tools' >> ~/.bash_profile
  source ~/.bash_profile
  ~~~

  **Windows** Powershell
  ~~~
  $PATH = [Environment]::GetEnvironmentVariable("PATH")
  $USER = "<YOUR_USERNAME>"
  $DICOM_TOOLS_HOME = "C:\Users\$USER\docker_dicom_tools\"
  [Environment]::SetEnvironmentVariable("PATH", "$PATH;$DICOM_TOOLS_HOME")
  ~~~

5. Use the `dicom_tools_run.sh` (or `dicom_tools_run.bat` on **Windows**) script to run available DICOM tools (listed below) within the docker container.

  Show example version messages
  ~~~
  dicom_tools_run.sh dcuidchg -version
  dicom_tools_run.sh dcm2pdf --version
  dicom_tools_run.sh dcmsnd --version
  dicom_tools_run.sh dcm2json --version
  ~~~

  Note that some tool names, e.g., `dcm2xml`, appear in multiple tool boxes and a full path to the exact executable you want may be necessary. The order of precedence is **dcm4che3** > **dcm4che2** > **dcmtk**.
  ~~~
  # dcm4che3
  dicom_tools_run.sh dcm2xml --version

  # dcm4che2
  dicom_tools_run.sh /dcm4che-2.0.29/bin/dcm2xml --version

  # dcmtk
  dicom_tools_run.sh /usr/bin/dcm2xml --version
  ~~~

  Convert multiframe enhanced MR DICOM to classic DICOM. Input and output of files is via the present working directory in which `dicom_tools_run.sh` is invoked.
  ~~~
  cd ~/docker_dicom_tools/dicom_examples
  dicom_tools_run.sh dcuncat -output-file DCM_CLASSIC_MR_SURVEY -framesper 1 DCM_ENHANCED_MR_SURVEY
  ~~~

Available Tools
===============

[dicom3tools](http://www.dclunie.com/dicom3tools)
-------------
available in `/usr/local/bin`
~~~
ancp      dcfile     dcsrmrg     gendump    pqdump
ancreate  dchist     dcstats     gentodc    pqsplit
andump    dciodvfy   dcsub       gentopgm   pqtodc
antodc    dckey      dctable     himrdump   rawarith
binpatch  dclutburn  dctopdf     himrtodc   rawdiff
bmpdump   dclutdmp   dctopgm8    imtndump   rawftodc
dcarith   dclutmix   dctopgx     imtntodc   rawmask
dcbriggs  dcmerge    dctopnm     jpegdump   rawnjl
dcburn    dcmkpres   dctoraw     jpegsplit  rawnjl2
dccomb    dcmulti    dcuidchg    pacedump   rawtodc
dccp      dcortho    dcuncat     pacetodc   sgndump
dcdecmpr  dcostosr   dcunmeta    pacetopgm  sgntodc
dcdict    dcposn     dumptiff    pbmswbit   sgntopgm
dcdirdmp  dcpost     dumpwhat    pbmtoovl   shimdump
dcdirmk   dcproj     gawdump     pdftodc    shimtodc
dcdisp    dcrmmeta   gawtodc     pgmtobmp   sompdump
dcdtchg   dcsmpte    ge9800dump  pgxtodc    somptodc
dcdump    dcsort     ge9800todc  pnmpred    somtopgm
dcencap   dcsqextr   ge98id      pnmtodc    syttopgm
dcentvfy  dcsrdump   ge98topgm   pnmtoraw   vsntopgm
~~~

[dcmtk](http://dcmtk.org/dcmtk.php.en)
-------
available in `/usr/bin`
~~~
dcm2pdf   dcmdump   dcmprscu  dcmsign   pdf2dcm
dcm2pnm   dcmftest  dcmpschk  dcod2lum  storescp
dcm2xml   dcmgpdir  dcmpsmk   dconvlum  storescu
dcmcjpeg  dcmj2pnm  dcmpsprt  dsr2html  termscu
dcmcjpls  dcml2pnm  dcmpsrcv  dsr2xml   wlmscpfs
dcmconv   dcmmkcrv  dcmpssnd  dsrdump   xml2dcm
dcmcrle   dcmmkdir  dcmqridx  dump2dcm  xml2dsr
dcmdjpeg  dcmmklut  dcmqrscp  echoscu
dcmdjpls  dcmodify  dcmqrti   findscu
dcmdrle   dcmp2pgm  dcmquant  img2dcm
dcmdspfn  dcmprscp  dcmscale  movescu
~~~

[dcm4che2](https://sourceforge.net/projects/dcm4che/files/dcm4che2/)
---------
available in `/dcm4che-2.0.29/bin`
~~~
dcm2dcm  dcmhpqr   dcmups     logger     rgb2ybr
dcm2jpg  dcmmover  dcmwado    metaphone  soundex
dcm2txt  dcmmwl    esoundex   mkelmdic   txt2dcmsr
dcm2xml  dcmof     esoundex2  mkuiddic   xml2dcm
dcmdir   dcmqr     fixjpegls  mkvrmap
dcmecho  dcmrcv    jpg2dcm    pdf2dcm
dcmgpwl  dcmsnd    kphonetik  phonem
~~~

[dcm4che3](https://sourceforge.net/projects/dcm4che/files/dcm4che3/)
---------
available in `/dcm4che-3.3.7/bin`
~~~
dcm2dcm      emf2sf     ianscu     phonem     syslog
dcm2jpg      esoundex   jpg2dcm    prefs2xml  syslogd
dcm2json     esoundex9  json2dcm   probetc    wadors
dcm2xml      findscu    kphonetik  qc         wadouri
dcmdict      getscu     metaphone  qidors     xml2dcm
dcmdir       hl72xml    mkkos      soundex    xml2hl7
dcmdump      hl7pix     modality   stgcmtscu  xml2prefs
dcmgen       hl7rcv     movescu    storescp
dcmqrscp     hl7snd     mppsscp    storescu
dcmvalidate  ianscp     mppsscu    stowrs
~~~

Some of the above **dcm4che** tools, such as `dcm2xml`, `dcmdump`, `storescp`, `storescu`, `xml2dcm` conflict with **dcmtk** tools. Use full path including specific `bin` folder to avoid ambiguity in such cases, e.g., `/usr/bin/dcm2xml` for **dcmtk** or `/dcm4che-3.3.7/bin/dcm2xml` for **dcmche3**.

**dcmche3** has precedence over **dcm4che2** in the search path. To use **dcm4che2** tools, use a full path such as `/dcm4che-2.0.29/bin/dcm2dcm`.

Build from Dockerfile
=====================

To build the **dicom_tools** docker image use the included `docker_build.sh` script. After the docker image is created by the script, it is saved as a gzipped tar file `dicom_tools.tar.gz` in the `docker_dicom_tools/docker_save/` folder.

~~~
# build dicom_tools docker image from scratch
~/docker_dicom_tools/docker_build.sh
~~~

The `dicom_tools.tar.gz` can be loaded with the following command.

~~~
docker load < ~/docker_dicom_tools/docker_save/dicom_tools.tar.gz
~~~
