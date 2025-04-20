FROM debian:stable-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends shairport-sync gmediarender \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad && \
    apt-get autoremove -y && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

#FROM scratch
#COPY --from=base / /

ENV TZ=Asia/Shanghai

LABEL maintainer="Limory" \
      source="https://github.com/limory/hi3798mv100-server-tools"

COPY ./run.sh /root/run.sh

RUN chmod +x /root/run.sh

CMD ["-v"]

ENTRYPOINT ["/root/run.sh"]

#build
#docker build -t airplay-dlna:v2 .
#usage
#docker run -itd -v /opt/airplay/shairport-sync.conf:/etc/shairport-sync.conf -v /etc/asound.conf:/etc/asound.conf -h i7 --name i7 --restart always --net host --device /dev/snd airplay-dlna:v2
