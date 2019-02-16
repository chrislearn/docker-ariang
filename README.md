# [Aria2](https://github.com/aria2/aria2) + [AriaNg webui](https://github.com/mayswind/AriaNg) inside a docker container

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
| x86_64 | x86_64 |
| aarch64 | aarch64 |

### Simple Usage

```bash
docker run -d --name ariang -p 80:80 -p 6800:6800 lisaac/ariang:`arch`
```

### Full Usage

```bash
docker run -d \
    --name ariang \
    -p 6800:6800 \
    -p 80:80 \
    -v /DOWNLOAD_DIR:/aria2/data \
    -v /CONFIG_DIR:/aria2/conf \
    -e PUID=1000 \
    -e PGID=1000 \
    -e RPC_SECRET=NOBODYKNOWSME \
    -e ENABLE_AUTH=true \
    -e ARIANG_USER=user \
    -e ARIANG_PWD=password \
    lisaac/ariang:`arch`
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
git clone https://github.com/lisaac/aria2-ariang-docker
cd aria2-ariang-docker
docker build -t ariang .
```

## Docker Hub

  <https://hub.docker.com/r/lisaac/ariang/>

## Usage it in Docker compose

  Todo