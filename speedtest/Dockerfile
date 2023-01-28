FROM debian:stable-slim

RUN apt-get update --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y curl cron python3 && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install -y speedtest  && \
    apt-get clean

RUN touch /var/log/speedtest.log

COPY cron/speedtest.py .
RUN chmod +x speedtest.py

ADD cron/crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file

RUN crontab /etc/cron.d/my-cron-file

ENTRYPOINT ["cron", "-f"]
