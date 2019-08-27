# [Aria2](https://github.com/aria2/aria2) + [AriaNg webui](https://github.com/mayswind/AriaNg) inside a docker container

[![badge](https://images.microbadger.com/badges/image/hurlenko/aria2-ariang.svg)](https://microbadger.com/images/hurlenko/aria2-ariang "Get your own image badge on microbadger.com")

- [How to run](#how-to-run)
  - [Simple Usage](#simple-usage)
  - [Full Usage](#full-usage)
  - [Supported Environment Variables](#supported-environment-variables)
  - [Supported Volumes](#supported-volumes)
- [Docker Hub](#docker-hub)
- [Usage it in Docker compose](#usage-it-in-docker-compose)

## Aria2

![AriaNg](https://raw.githubusercontent.com/mayswind/AriaNg-WebSite/master/screenshots/desktop.png)

## How to run

### Supported Architectures

This project utilises the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| amd64 | amd64 |
| arm64 | arm64 |

### Simple Usage

```bash
docker run -d --name aria2-ui -p 80:80 -p 6800:6800 hurlenko/aria2-ariang
```

### Full Usage

```bash
docker run -d \
    --name aria2-ui \
    -p 6800:6800 \                    # aria2 rpc
    -p 80:80 \                        # webui
    -v /DOWNLOAD_DIR:/aria2/data \    # replace /DOWNLOAD_DIR with your download directory in your host.
    -v /CONFIG_DIR:/aria2/conf \      # replace /CONFIG_DIR with your configure directory in your host.
    -e PUID=1000 \                    # replace 1000 with the userid who will own all downloaded files and configuration files.
    -e PGID=1000 \                    # replace 1000 with the groupid who will own all downloaded files and configuration files.
    -e RPC_SECRET=NOBODYKNOWSME \     # replace NOBODYKNOWSME with the secret for access Aria2 RPC services.
    hurlenko/aria2-ariang
```

> Note: defaut rpc secret is `secret`. You can also remove secret by overriding `RPC_SECRET` with empty string when running your container:

```bash
-e RPC_SECRET=""
```

Now head to <http://yourip> open settings, enter your secret and you're good to go

### Supported Environment Variables

- `PUID` Userid who will own all downloaded files and configuration files (Default `0` which is root)
- `PGID` Groupid who will own all downloaded files and configuration files (Default `0` which is root)
- `RPC_SECRET` The Aria2 RPC secret token (Default `secret`)
- `DOMAIN` The domain you'd like to bind (Default `0.0.0.0:80`)

### Supported Volumes

- `/aria2/data` The folder of all Aria2 downloaded files
- `/aria2/conf` The Aria2 configuration file

### User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```bash
$ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

### How to build

```bash
git clone https://github.com/hurlenko/aria2-ariang-docker
cd aria2-ariang-docker
docker build -t aria2-ui .
```

## Docker Hub

  <https://hub.docker.com/r/hurlenko/aria2-ariang/>

## Usage it in Docker compose

  Todo