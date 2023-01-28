#!/usr/bin/env python3

import statsd
from time import sleep
from random import randint, choice

import os
import re
import subprocess
import time

statsClient = statsd.StatsClient('telegraf', 8125, prefix='performance')
print("StatsClient - " + str(statsClient))

i = 0
while i < 10:
    incr = randint( 1, 5 )
    timing = randint( 100, 400 )
    metric_type = choice(['A', 'B', 'C'])
    print( f"\radding metric: type: {metric_type}, incr: {incr}, timing {timing} ms", end="")
    statsClient.incr(f'request.successful.count,type={metric_type}', incr)  # Increment counter
    statsClient.timing(f'request.successful.time,type={metric_type}', timing )
    sleep( randint(5, 55) / 1000 )

# response = subprocess.Popen('/usr/bin/speedtest --accept-license --accept-gdpr', shell=True, stdout=subprocess.PIPE)\
#     .stdout.read().decode('utf-8')
#
# ping = re.search('Latency:\s+(.*?)\s', response, re.MULTILINE)
# download = re.search('Download:\s+(.*?)\s', response, re.MULTILINE)
# upload = re.search('Upload:\s+(.*?)\s', response, re.MULTILINE)
# jitter = re.search('Latency:.*?jitter:\s+(.*?)ms', response, re.MULTILINE)
#
# ping = ping.group(1)
# download = download.group(1)
# upload = upload.group(1)
# jitter = jitter.group(1)
#
# print("download " + str(download))

