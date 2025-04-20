FROM debian:stable-slim AS base

RUN apt-get update && apt-get install -y shairport-sync build-essential autoconf automake libtool pkg-config \
                       libupnp-dev libgstreamer1.0-dev \
                       gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
                       gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
                       gstreamer1.0-libav gstreamer1.0-alsa \
                       git && \
    git clone https://github.com/hzeller/gmrender-resurrect.git /gmr && \
    cd /gmr && ./autogen.sh && ./configure && make && make install && \
    apt-get remove -y build-essential autoconf automake libtool pkg-config git && \
    apt-get autoremove -y && apt-get clean && apt-get autoclean && \
    rm -rf /gmr /var/lib/apt/lists/*
    
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
