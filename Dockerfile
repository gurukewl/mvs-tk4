FROM ubuntu:22.04 as builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yq unzip apt-utils
WORKDIR /tk4/
RUN wget --no-check-certificate https://archive.org/download/tk4_ispf.tar/tk4_ispf.tar.gz /tk4/
RUN tar -xf tk4_ispf.tar.gz && \
    rm -rf /tk4/tk4_ispf.tar.gz
RUN cd /tk4/archive.org && \
    cp -r * /tk4  
RUN rm -rf /tk4/hercules/darwin && \
    rm -rf /tk4/hercules/windows && \
    rm -rf /tk4/hercules/source && \
    apt-get -y purge wget unzip && \
    apt-get -y autoclean && apt-get -y autoremove && \
    apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /archieve.org

#FROM ubuntu:22.04
#WORKDIR /tk4/
#COPY --from=builder /tk4/ .
#RUN rm -rf /archieve.org
VOLUME [ "/tk4/conf","/tk4/local_conf","/tk4/local_scripts","/tk4/prt","/tk4/dasd","/tk4/pch","/tk4/jcl","tk4/log" ]
CMD ["/tk4/mvs"]
EXPOSE 3270 8038
