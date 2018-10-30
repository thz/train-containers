FROM docker
RUN apk --update add socat
EXPOSE 80
CMD socat tcp-listen:80,fork,reuseaddr system:"echo HTTP/1.0 200; echo content-type\: text/plain;echo;docker stats --all --no-trunc --no-stream"
