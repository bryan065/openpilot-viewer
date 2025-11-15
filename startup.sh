#!/bin/bash

mkdir -p /data/metadata
mkdir -p /data/raw
mkdir -p /data/stitched
mkdir -p /data/logs
mkdir -p /data/ssh

chown -R 1000:100 /data/metadata
chown -R 1000:100 /data/raw
chown -R root:www-data /data/stitched
chown -R 1000:100 /data/logs
chown -R 1000:100 /data/ssh

service nginx start
gunicorn openpilot_viewer.wsgi:application --bind 0.0.0.0:8000