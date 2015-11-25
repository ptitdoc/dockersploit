FROM 
MAINTAINER Pentester

ENV PKG_JSON_URL=https://raw.githubusercontent.com/ptitdoc/dockersploit/master/package.json\
    TAR_GZ_URL=https://github.com/ptitdoc/dockersploit/archive/master.tar.gz
    BUILD_DEPS='gcc g++ git make python bash'

RUN mkdir -p /pentest
RUN mkdir -p /pentest-data
WORKDIR /pentest

ADD $PKG_JSON_URL ./package.json
ADD $TAR_GZ_URL ./master.tar.gz
RUN set -x \
&& tar -xzvf master.tar.gz \
&& ./meterpreter

RUN groupadd -r pentest \
&& useradd -r -g pentest pentest \
&& chown pentest:pentest /pentest-data

USER pentest 

EXPOSE 4444

#VOLUME ["/pentest-data"]

CMD ["/pentest/meterpreter"]
