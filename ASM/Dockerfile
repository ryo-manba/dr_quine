FROM debian:latest

RUN apt-get update && \
    apt-get install -y \
    nasm \
    gcc \
    libc6-dev \
    vim \
    make \
    file \
    binutils \
    auditd \
    lldb \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/workspace

VOLUME ["/usr/workspace"]

CMD ["/bin/bash"]