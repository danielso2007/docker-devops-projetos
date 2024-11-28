FROM sonarqube:9.9.7-community
USER root
RUN usermod -aG sudo sonarqube
RUN apt-get -qq update
RUN apt-get -qq install wget unzip nano
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_23.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh 
RUN apt install -y nodejs
RUN echo "networkaddress.cache.ttl=5" >> "${JAVA_HOME}/conf/security/java.security"