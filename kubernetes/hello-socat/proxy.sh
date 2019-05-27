#!/bin/sh

kubectl proxy --port 12345 &

sleep 1
curl http://127.0.0.1:12345/api/v1/namespaces/default/services/hello-svc/proxy/
