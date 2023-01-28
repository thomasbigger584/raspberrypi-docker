#!/usr/bin/env python3

import re
import subprocess

import statsd

statsClient = statsd.StatsClient('telegraf', 8125, prefix='performance')

response = subprocess.Popen('/usr/bin/speedtest --accept-license --accept-gdpr', shell=True, stdout=subprocess.PIPE) \
    .stdout.read().decode('utf-8')

ping = re.search('Latency:\s+(.*?)\s', response, re.MULTILINE)
download = re.search('Download:\s+(.*?)\s', response, re.MULTILINE)
upload = re.search('Upload:\s+(.*?)\s', response, re.MULTILINE)
jitter = re.search('Latency:.*?jitter:\s+(.*?)ms', response, re.MULTILINE)

ping = ping.group(1)
download = download.group(1)
upload = upload.group(1)
jitter = jitter.group(1)

statsClient.timing(f'request.successful.time,type=ping', float(ping))
statsClient.timing(f'request.successful.time,type=download', float(download))
statsClient.timing(f'request.successful.time,type=upload', float(upload))
statsClient.timing(f'request.successful.time,type=jitter', float(jitter))

statsClient.timing(f'request.successful.time,type=ping', float(ping))
statsClient.timing(f'request.successful.time,type=download', float(download))
statsClient.timing(f'request.successful.time,type=upload', float(upload))
statsClient.timing(f'request.successful.time,type=jitter', float(jitter))

