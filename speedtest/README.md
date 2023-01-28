
## Start docker image
```shell
docker-compose build && docker-compose up
```

## View output
```shell
docker exec -it speedtest-speedtest-1  bash -c "tail /var/log/speedtest.log -f"
```

## Note

May have to give permissions to volume folder for grafana database to be created
```shell
chmod 777 -R ~/volumes/speedtest/grafana
```

## Links
https://pimylifeup.com/raspberry-pi-internet-speed-monitor/
https://github.com/bcremer/docker-telegraf-influx-grafana-stack
