FROM centos:7
MAINTAINER Pentester

#ENV PKG_JSON_URL=https://raw.githubusercontent.com/ptitdoc/dockersploit/master/package.json\
ENV TAR_GZ_URL https://github.com/ptitdoc/dockersploit/archive/master.tar.gz
ENV BUILD_DEPS 'python gcc gcc-c++ git make bash'
ENV http_proxy $http_proxy
ENV https_proxy $https_proxy

RUN echo "HTTP Proxy: $http_proxy"
RUN echo "HTTPS Proxy: $https_proxy"
RUN echo "Pentest: $pentest"

RUN echo "Updating packages"
RUN yum install $BUILD_DEPS

RUN echo "Creating directories"

RUN mkdir -p /pentest
RUN mkdir -p /pentest-data
WORKDIR /pentest

RUN echo "Decompressing GIT"

#ADD $PKG_JSON_URL ./package.json
ADD $TAR_GZ_URL ./master.tar.gz
RUN set -x \
&& tar -xzvf master.tar.gz

RUN echo "Running MSFVENOM"
#RUN msfvenom --platform linux -p linux/x64/shell/bind_tcp lport=8080 -f elf -o payload

RUN echo "Creating user"
RUN groupadd -r pentest \
&& useradd -r -g pentest pentest \
&& chown pentest:pentest /pentest-data

RUN echo "Docker configuration"
#USER pentest 

EXPOSE 8080

#VOLUME ["/pentest-data"]

#CMD python -m SimpleHTTPServer 8080
CMD python -c "print ('Hello python toto')"
#CMD ["/pentest/payload"]
