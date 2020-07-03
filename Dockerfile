ARG ALPINE_VERSION=3.10

FROM alpine:${ALPINE_VERSION} as binaries

ARG HLF_VERSION=2.1.1

RUN apk --no-cache add curl

WORKDIR /fabric-binaries

RUN curl --fail --silent --show-error -L "https://github.com/hyperledger/fabric/releases/download/v${HLF_VERSION}/hyperledger-fabric-linux-amd64-${HLF_VERSION}.tar.gz" -o "/tmp/hyperledger-fabric-linux-amd64-${HLF_VERSION}.tar.gz" && \
    tar -xzf "/tmp/hyperledger-fabric-linux-amd64-${HLF_VERSION}.tar.gz"

FROM alpine:${ALPINE_VERSION}

ENV FABRIC_CFG_PATH /etc/hyperledger/fabric

WORKDIR /etc/hyperledger/fabric

COPY --chown=0:0 --from=binaries /fabric-binaries/bin /usr/local/bin
COPY --chown=0:0 --from=binaries /fabric-binaries/config /etc/hyperledger/fabric

#WORKDIR /tbc

#CMD tbc
