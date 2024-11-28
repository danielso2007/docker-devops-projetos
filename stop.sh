#/usr/bin/bash
clear
docker compose stop &
wait $!
docker compose ps