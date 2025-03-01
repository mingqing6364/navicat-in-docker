# 封装成Docker镜像，可以使用web或vnc访问的Navicat

## 为何？

***<font color=red>原则上来说，不应该直接操作线上环境的数据库。</font>***

实际上总有一些不可避免的情况，需要DBA介入，操作业务数据。

哪怕是再怎么熟练的DBA，也无法否认，相比shell命令行，navicat要方便很多。

如果可以的话，至少我是希望能够在GUI中操作数据库，哪怕是生产环境。

但是：

- 并不是每个项目都配备了Windows或者带GUI的Linux运维机。
- 有些项目配置了堡垒机，无法通过SSH隧道访问内部的服务。
- 使用Navicat的Http代理，需要搭建PHP环境，并且导致大量数据通过web服务传入传出。

所以将novnc + Navicat封装成了Docker镜像，方便部署使用。

## 感谢

镜像底包: https://github.com/jlesage/docker-baseimage-gui

Navicat: https://www.navicat.com.cn/
> 请购买正版授权

## 使用方法

### 按需选择镜像，并拉取
> 不提供SQL Server版：虽然支持，但是应该没有多少人在生产环境中使用Linux部署MSSQL吧？
> 不提供Sqlite版：一般来说Sqlite文件不大，多用于配置记录，完全可以下载下来操作。

```bash
docker pull mingqing6364/navicat:Premium-17
docker pull mingqing6364/navicat:Premium-Lite-17
docker pull mingqing6364/navicat:MySQL-17
docker pull mingqing6364/navicat:PostgreSQL-17
docker pull mingqing6364/navicat:MongoDB-17
docker pull mingqing6364/navicat:MariaDB-17
docker pull mingqing6364/navicat:Oracle-17
docker pull mingqing6364/navicat:Redis-17
```

### docker run 启动

```bash
docker run -d --rm \
  --name=navicat17 \
  -p 5800:5800/tcp \
  -e DISPLAY_WIDTH=1920 \
  -e DISPLAY_HEIGHT=1080 \
  -e VNC_PASSWORD="VPN密码(强烈推荐设置复杂密码)" \
  -v ${PWD}/navicat:/root/.config/navicat \
  mingqing6364/navicat:Premium-17
```

### docker-compose 启动

```bash
version: '3' 
services:
    navicat17:
        image: mingqing6364/navicat:Premium-17
        container_name: navicat17
        ports:
            - '5800:5800/tcp'
        volumes:
            - '${PWD}/navicat:/root/.config/navicat'
        environment:
            - 'DISPLAY_WIDTH=1920'
            - 'DISPLAY_HEIGHT=1080'
            - 'VNC_PASSWORD="VPN密码(强烈推荐设置复杂密码)"'
```

### 访问

http://ip:5800
