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

stop_pihole() {
  cd "$SCRIPT_DIR/pihole" || exit 1
  echo "__________ Stopping PIHOLE __________"
  docker compose down --remove-orphans
}

stop_portainer() {
  cd "$SCRIPT_DIR/portainer" || exit 1
  echo "__________ Stopping PORTAINER __________"
  docker compose down --remove-orphans
}

stop_speedtest() {
  cd "$SCRIPT_DIR/speedtest" || exit 1
  echo "__________ Stopping SPEEDTEST __________"
  docker compose down --remove-orphans
}

stop_webmin() {
  cd "$SCRIPT_DIR/webmin" || exit 1
  echo "__________ Stopping WEBMIN __________"
  docker compose down --remove-orphans
}

stop_nginx() {
  cd "$SCRIPT_DIR/nginx" || exit 1
  echo "__________ Stopping NGINX __________"
  docker compose down --remove-orphans
}

stop_pihole
stop_portainer
stop_speedtest
stop_webmin
stop_nginx

docker system prune -f
docker container ps

exit 0
