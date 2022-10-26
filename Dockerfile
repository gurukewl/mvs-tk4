FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yq unzip apt-utils wget binutils && \
    mkdir /tk4 && \
    cd /tk4 && \
    wget --no-check-certificate https://archive.org/download/tk4_ispf.tar/tk4_ispf.tar.gz && \
    tar -xf tk4_ispf.tar.gz && \
    rm -rf /tk4/tk4_ispf.tar.gz && \
    cd  /tk4/archive.org && \
    cp -r * /tk4 && \  
    rm -rf /tk4/hercules/darwin && \
    rm -rf /tk4/hercules/windows && \
    rm -rf /tk4/hercules/source && \
    apt-get -y purge wget unzip && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tk4/archive.org && \
    rm -rf /tk4/ctca_demo && \ 
    rm /tk4/README_*

WORKDIR /tk4/
VOLUME [ "/tk4/conf","/tk4/local_conf","/tk4/local_scripts","/tk4/prt","/tk4/dasd","/tk4/pch","/tk4/jcl","tk4/log" ]
EXPOSE 3270 8038
ENTRYPOINT ["/tk4/mvs"]
