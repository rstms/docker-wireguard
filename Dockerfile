ARG ubuntu_codename=bionic

FROM ubuntu:${ubuntu_codename}

ENV DEBIAN_FRONTEND="noninteractive"
ARG ubuntu_codename=bionic

RUN apt-get update &&\
    apt-get install --yes --no-install-recommends\
    software-properties-common gnupg iproute2 iptables ifupdown iputils-ping make gcc cpp binutils dkms kmod &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:wireguard/wireguard
    
RUN apt-get install -y wireguard wireguard-tools wireguard-dkms

RUN apt-get update &&\
    apt-get install --yes --no-install-recommends linux-headers-$(uname -r) &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN dkms uninstall wireguard/$(dkms status | awk -F ', ' '{ print $2 }')

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "run-server" ]
