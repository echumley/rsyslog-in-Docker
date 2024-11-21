FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y rsyslog net-tools\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Custom rsyslog configuration
COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 514/tcp
EXPOSE 514/udp

CMD ["rsyslogd", "-n"]