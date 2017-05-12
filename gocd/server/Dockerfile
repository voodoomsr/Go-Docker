FROM openjdk:8-jdk-alpine

VOLUME /godata

RUN ln -sf /godata/ssh-keys ~/.ssh

RUN apk update && \
    apk add ca-certificates bash wget git openssh perl-net-telnet && \
    update-ca-certificates

    RUN wget -O /tmp/gocd-installer.zip https://download.gocd.io/binaries/17.3.0-4704/generic/go-server-17.3.0-4704.zip && \
        unzip -d /tmp /tmp/gocd-installer.zip && \
        mkdir /opt && mv /tmp/go-server-17.3.0 /opt/gocd-server

    RUN mkdir -p /opt/gocd-server/plugins/ && \
        ln -sf /godata/db /opt/gocd-server/db && \
        ln -sf /godata/config /opt/gocd-server/config && \
        ln -sf /godata/artifacts /opt/gocd-server/artifacts

    COPY resources/config-init.sh   /
    COPY resources/base-config      /base-config

    RUN wget -P /opt/gocd-server/plugins/external/ https://github.com/tomzo/gocd-yaml-config-plugin/releases/download/0.4.0/yaml-config-plugin-0.4.0.jar
    RUN wget -P /opt/gocd-server/plugins/external/ https://github.com/gocd-contrib/gocd-oauth-login/releases/download/v2.3/google-oauth-login-2.3.jar

    EXPOSE 8153 8154

    WORKDIR /opt/gocd-server

    RUN chmod +x /config-init.sh
    CMD /config-init.sh && ./server.sh
