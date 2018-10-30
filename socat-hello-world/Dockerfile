FROM debian
RUN apt-get update && apt-get install -y socat
CMD socat tcp-listen:80,fork,reuseaddr system:"echo HTTP/1.0 200; echo content-type\: text/plain;echo;echo Hello World"
