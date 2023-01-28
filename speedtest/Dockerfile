FROM debian:stable-slim

RUN apt-get update --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y curl cron python3-pip python3 && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install -y speedtest  && \
    apt-get clean

ADD cron/crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file
RUN crontab /etc/cron.d/my-cron-file

RUN touch /var/log/speedtest.log

WORKDIR /app
COPY app/ .

RUN chmod +x speedtest.py
RUN pip3 install -r requirements.txt

ENTRYPOINT ["cron", "-f"]
