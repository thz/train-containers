FROM debian:stable-slim

RUN apt-get update && apt-get install -y apache2

EXPOSE 80
ENTRYPOINT [ "apache2ctl" , "-DFOREGROUND" ]
