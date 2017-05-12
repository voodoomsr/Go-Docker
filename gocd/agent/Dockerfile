FROM openjdk:8-jdk-alpine

VOLUME /godata

ENV GO_SERVER_URL   https://server:8154/go
ENV GO_AGENT_DIR    /opt/gocd-agent

ENV GO_AGENT_AUTOREGISTER_KEY       388b633a88de126531afa41eff9aa69e
ENV GO_AGENT_AUTOREGISTER_RESOURCE  rpibase

RUN ln -sf /godata/ssh-keys ~/.ssh

RUN apk update && \
    apk add ca-certificates bash wget git openssh libstdc++ curl perl-net-telnet && \
    update-ca-certificates

RUN wget -O /tmp/gocd-installer.zip https://download.gocd.io/binaries/17.3.0-4704/generic/go-agent-17.3.0-4704.zip && \
    unzip -d /tmp /tmp/gocd-installer.zip && \
    mkdir -p $(dirname $GO_AGENT_DIR) && \
    mv /tmp/go-agent-17.3.0 $GO_AGENT_DIR

COPY resources/autoregister.sh /

WORKDIR $GO_AGENT_DIR

RUN chmod +x /autoregister.sh
CMD /autoregister.sh && ./agent.sh
