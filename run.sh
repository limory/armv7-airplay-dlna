#!/bin/sh

if [ -z "${GMR_ARG}" ] ; then
    gmediarender -f "DLNA-$HOSTNAME" &
    if [ $? -ne 0 ]; then
        echo "gmediarender 启动失败"
        exit 1
    fi
else
    gmediarender -f "DLNA-$HOSTNAME" "$GMR_ARG" &
    if [ $? -ne 0 ]; then
        echo "gmediarender 启动失败"
        exit 1
    fi
fi

dbus-daemon --system --nofork --nopidfile &

sleep 1

if pgrep dbus-daemon; then
    echo "DBus 服务启动成功"
else
    echo "DBus 服务启动失败"
fi

if avahi-daemon -D --no-chroot; then
    echo "Avahi 守护进程启动成功"
else
    echo "Avahi 守护进程启动失败"
fi

while ! ( pgrep avahi-daemon && pgrep dbus-daemon ) > /dev/null ; do
    
    echo "提示: Dbus 或 Avahi 启动失败，等待5秒重新启动！"
    
    pkill dbus-daemon

    pkill avahi-daemon
    
    #service dbus start
    dbus-daemon --system --nofork --nopidfile &

    rm -rf /var/run/avahi-daemon

    avahi-daemon -D --no-chroot

    sleep 5
    
done

echo "启动 Shairport-sync for Airplay Receiver"

shairport-sync "$@"
