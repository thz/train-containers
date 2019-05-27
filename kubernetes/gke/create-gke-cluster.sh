#!/bin/sh

gcloud container clusters \
  create my-gke-cluster \
  --zone europe-west3-c \
  --num-nodes 2
