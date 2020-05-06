FROM judge0/api-base:1.2.1-slim

# Python for ML
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install \
        mlxtend \
        numpy \
        pandas \
        scikit-learn \
        scipy && \
    rm -rf /var/lib/apt/lists/*

# Nim
COPY ./bin/update/nim /update/
RUN set -xe && \
    /update/nim

# MPI for C, C++ and Python
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends libopenmpi-dev python3-mpi4py && \
    rm -rf /var/lib/apt/lists/*

# Java
RUN set -xe && \
    curl -fSsL "https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_linux-x64_bin.tar.gz" -o /tmp/openjdk14.tar.gz && \
    mkdir /usr/local/openjdk14 && \
    tar -xf /tmp/openjdk14.tar.gz -C /usr/local/openjdk14 --strip-components=1 && \
    rm -rf /tmp/*

# JUnit Platform Console Standalone
RUN set -xe && \
    mkdir /usr/local/junit-platform-console-standalone-1.6.2 && \
    cd /usr/local/junit-platform-console-standalone-1.6.2 && \
    curl -fSsL "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.6.2/junit-platform-console-standalone-1.6.2.jar" -o launcher.jar

# C3
COPY ./bin/update/c3 /update/
RUN set -xe && \
    echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main" > /etc/apt/sources.list.d/llvm.list && \
    echo "deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main" >> /etc/apt/sources.list.d/llvm.list && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends clang-10 cmake cmake-extras llvm-10-dev && \
    /update/c3 && \
    rm -rf /var/lib/apt/lists/*

COPY cron /etc/cron.d
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends cron && \
    rm -rf /var/lib/apt/lists/* && \
    cat /etc/cron.d/* | crontab -

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="1.2.1-extra"