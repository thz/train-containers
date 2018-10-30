#!/bin/sh


printf "\ndefault:\n"
docker run bash -c "chown -v 35 /etc/passwd ; ls -l /etc/passwd"
printf "\nwith reduced caps:\n"
docker run --cap-drop CHOWN bash -c "chown -v 35 /etc/passwd ; ls -l /etc/passwd"
