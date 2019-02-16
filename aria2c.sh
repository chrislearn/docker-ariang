#!/bin/sh

conf_path=/aria2/conf
conf_copy_path=/aria2/conf-copy
data_path=/aria2/data

if [ ! -f $conf_path/aria2.conf ]; then
    cp $conf_copy_path/aria2.conf $conf_path/aria2.conf

fi

touch $conf_path/aria2.session

chown -R daemon:daemon $conf_path
chown -R daemon:daemon $data_path

if [ -n "$RPC_SECRET" ]; then
    RPC_PARAMETER="--rpc-secret=`echo $RPC_SECRET`"
fi

su -s/bin/sh -c"caddy -quiet -conf /etc/Caddyfile" daemon && \
su -s/bin/sh -c"aria2c --log=$conf_path/aria2.log --conf-path=$conf_path/aria2.conf $RPC_PARAMETER" daemon
