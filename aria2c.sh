#!/bin/sh

conf_path=/aria2/conf
conf_copy_path=/aria2/conf-copy
data_path=/aria2/data

if [ ! -f "$conf_path"/aria2.conf ]; then
    cp "$conf_copy_path"/aria2.conf "$conf_path"/aria2.conf

fi

touch "$conf_path"/aria2.session

EXE_USER=`cat /etc/passwd | awk -F : '{print $1"\t"$3}' | grep "$PUID" |awk '{print $1}'`
EXE_GROUP=`cat /etc/group | grep "$PGID" | awk -F : '{print $1}'`

if [ ! -n "$EXE_GROUP" ]; then
    EXE_GROUP=aria2
    addgroup -g "$PGID" -S "$EXE_GROUP"
    echo $EXE_GROUP
fi

if [ ! -n "$EXE_USER" ]; then
    EXE_USER=aria2
    adduser "$EXE_USER" -u "$PUID" -SDH -G "$EXE_GROUP" -s /sbin/nologin
    echo $EXE_USER
fi

IS_IN_GROUP=`cat /etc/group | grep "$PGID" | grep "$EXE_USER"`

if [ ! -n "$IS_IN_GROUP" ]; then
	adduser "$EXE_USER" "$EXE_GROUP"
fi

chown -R $PUID:$PGID "$conf_path"
chown -R $PUID:$PGID "$data_path"

if [ -n "$RPC_SECRET" ]; then
    RPC_PARAMETER="--rpc-secret=`echo $RPC_SECRET`"
fi

su -s/bin/sh -c"caddy -quiet -conf /Caddyfile" "$EXE_USER" &
su -s/bin/sh -c"aria2c --log=$conf_path/aria2.log --conf-path=$conf_path/aria2.conf --input-file=$conf_path/aria2.session --save-session=$conf_path/aria2.session $RPC_PARAMETER" "$EXE_USER"
