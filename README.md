# armv7-airplay-dlna
Shairport-sync + gmrender-resurrect 构建 armv7 平台 airplay + dlna 的 docker 镜像  
#build  
#docker build -t airplay-dlna:v2 .  
#usage  
#docker run -itd -v /opt/airplay/shairport-sync.conf:/etc/shairport-sync.conf -v /etc/asound.conf:/etc/asound.conf -h i7 --name i7 --restart always --net host --device /dev/snd airplay-dlna:v2  
