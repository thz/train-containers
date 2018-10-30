#!/bin/bash

name=acme
image=jrcs/letsencrypt-nginx-proxy-companion:latest
if [ "$1" = "-f" ]; then
	docker stop $name
	docker rm $name
fi

CONTAINER_VOLUMES=/export/container/volumes

test -d $CONTAINER_VOLUMES/https/certs || exit 1

docker run -d \
	--name $name \
	--memory=80m \
	\
	-e DEBUG=true \
	\
	--volumes-from https \
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-v $CONTAINER_VOLUMES/https/certs:/etc/nginx/certs \
	-v $CONTAINER_VOLUMES/https/vhost.d:/etc/nginx/vhost.d \
	-v $CONTAINER_VOLUMES/https/html:/usr/share/nginx/html \
	\
	--network webnet \
	\
	$image
