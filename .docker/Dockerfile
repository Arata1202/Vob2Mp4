FROM jrottenberg/ffmpeg:4.1-ubuntu

WORKDIR /app

COPY .docker/entrypoint.sh ./

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
