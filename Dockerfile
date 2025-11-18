FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    nginx \
    ffmpeg \
    ssh \
    rsync \
    iputils-ping \
    cron \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

COPY nginx.conf /etc/nginx/sites-enabled/default

RUN mkdir -p /var/run/nginx

RUN chmod +x /app/c3x_sync.sh
RUN chmod +x /app/startup.sh
RUN chmod +x /app/startup_cron.sh

COPY sync_cron /data/sync_cron
RUN crontab /data/sync_cron

EXPOSE 80
