
## Start docker image
```shell
docker-compose build && docker-compose up
```

## View output
```shell
docker exec -it speedtest-speedtest-1  bash -c "tail /var/log/speedtest.log -f"
```
