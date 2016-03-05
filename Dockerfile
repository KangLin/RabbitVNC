#https://github.com/widuu/chinese_docker/blob/master/userguide/dockerimages.md

FROM ubuntu

MAINTAINER KangLin <kl222@126.com>

RUN apt-get update; \
    apt-get -y upgrade

RUN apt-get -y install g++ cmake git subversion wget ant
    
RUN cd /home; \
    git clone https://github.com/KangLin/rabbitvnc.git; \
    cd rabbitvnc; \
    ./travis/install-build-depends.sh; \
    ./travis/build-before.sh; \
    ./travis/build.sh
    

