#!/bin/bash

name=https
image=jwilder/nginx-proxy:latest
if [ "$1" = "-f" ]; then
	docker stop $name
	docker rm $name
fi

CONTAINER_VOLUMES=/export/container/volumes

bindip=0.0.0.0

docker run -d \
	--name $name \
	--memory=80m \
	--label com.github.jrcs.letsencrypt_nginx_proxy_companion.acme \
	-v /var/run/docker.sock:/tmp/docker.sock:ro \
	-v $CONTAINER_VOLUMES/https/certs:/etc/nginx/certs:ro \
	\
	-v $CONTAINER_VOLUMES/https/vhost.d:/etc/nginx/vhost.d \
	-v $CONTAINER_VOLUMES/https/html:/usr/share/nginx/html \
	\
	--network webnet \
	-p $bindip:80:80 \
	-p $bindip:443:443 \
	\
	$image
