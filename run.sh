#!/bin/sh

set -e -x 

USERID="$(id -u)"
GROUPID="$(id -g)"

xhost -
xhost "si:usergroup:1000"
if [[ "$USERID" != "1000" ]] || [[ "$GROUPID" != "1000" ]]; then
  echo "Warning: defaulting to semi-insecure x (userid != containerUserId)"
  xhost "local:root"
fi

docker run -it --rm --name parsec --env "DISPLAY=unix:0.0" -v /tmp/.X11-unix:/tmp/.X11-unix -v "/run/user/$USERID/pulse:/run/user/1000/pulse" -v /dev:/dev --privileged parsec
