FROM debian:latest

RUN apt-get update --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y curl cron && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install -y speedtest  && \
    apt-get clean

COPY cron/date-script.sh .
RUN chmod +x date-script.sh

ADD cron/crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file

# Running crontab
RUN crontab /etc/cron.d/my-cron-file

# Creating entry point for cron
ENTRYPOINT ["cron", "-f"]
