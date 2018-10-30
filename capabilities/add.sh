#!/bin/sh

printf "\ndefault:\n"
docker run --rm bash -c "ip link add dum0 type dummy ; ip a"

echo "\nwith --cap-add NET_ADMIN:\n"
docker run --cap-add NET_ADMIN --rm bash -c "ip link add dum0 type dummy ; ip a"
