FROM jrottenberg/ffmpeg:4.1-ubuntu

WORKDIR /app

COPY .docker/entrypoint.sh ./
COPY .env ./

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
