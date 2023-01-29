#!/usr/bin/env bash
set -e

check_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "This script needs run with sudo or run as root user"
    exit 1
  fi
}

case "$OSTYPE" in
darwin*) echo "Running on MacOS so don't need sudo" ;;
linux*) check_sudo ;;
*)
  echo "unknown: $OSTYPE"
  exit 1
  ;;
esac

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SELECTION_ON="on"

source "$SCRIPT_DIR/selection.txt"

wait_for_port() {
  port=$1
  until [ \
    "$(curl -s -w '%{http_code}' -o /dev/null "http://localhost:${port}")" -eq 200 ]; do
    echo "waiting for port ${port}"
    sleep 5
  done
}

start_pihole() {
  cd "$SCRIPT_DIR/pihole" || exit 1
  if [ $PIHOLE == $SELECTION_ON ]; then
    echo "__________ Starting PIHOLE __________"
    # dont force-recreate as it will reset the password
    docker compose up -d --remove-orphans
    wait_for_port 8081
  else
    echo "__________ Stopping PIHOLE __________"
    docker compose down --remove-orphans
  fi
}

start_portainer() {
  cd "$SCRIPT_DIR/portainer" || exit 1
  if [ $PORTAINER == $SELECTION_ON ]; then
    echo "__________ Starting PORTAINER __________"
    # dont force-recreate as it will reset the password
    docker compose up -d --remove-orphans
    wait_for_port 8082
  else
    echo "__________ Stopping PORTAINER __________"
    docker compose down --remove-orphans
  fi
}

start_speedtest() {
  cd "$SCRIPT_DIR/speedtest" || exit 1
  if [ $SPEEDTEST == $SELECTION_ON ]; then
    echo "__________ Starting SPEEDTEST __________"
    docker compose up -d --remove-orphans --build --force-recreate
    wait_for_port 8083
  else
    echo "__________ Stopping SPEEDTEST __________"
    docker compose down --remove-orphans
  fi
}

start_nginx() {
  cd "$SCRIPT_DIR/nginx" || exit 1
  if [ $NGINX == $SELECTION_ON ]; then
    echo "__________ Starting NGINX __________"
    docker compose up -d --force-recreate
    wait_for_port 80
  else
    echo "__________ Stopping NGINX __________"
    docker compose down --remove-orphans
  fi
}

start_pihole
start_portainer
start_speedtest
start_nginx

docker system prune -f
docker container ps

exit 0
