FROM judge0/api-base:2.0.0-base

# Latest version: https://www.mono-project.com/download/stable
ENV MONO_VERSIONS 6.8.0.123
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-transport-https dirmngr gnupg ca-certificates && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends mono-devel mono-vbnc fsharp && \
    apt-get autoremove --purge && \
    rm -rf /tmp/* /var/lib/apt/lists/*

# Latest version: https://www.perl.org/get.html
ENV PERL_VERSIONS 5.28.1
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends perl && \
    apt-get autoremove --purge && \
    rm -rf /tmp/* /var/lib/apt/lists/*

COPY Dockerfile /

LABEL version="2.0.0"
LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
