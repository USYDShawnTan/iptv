![iptv](https://socialify.git.ci/USYDShawnTan/iptv/image?font=Inter&name=1&owner=1&pattern=Circuit+Board&theme=Light)

## 部署在 openwrt

### 需要有 docker 和 ipv6

```docker
docker run -d \
  --name=iptv \
  --net=host \
  --restart=unless-stopped \
  -v /root/iptv/config:/iptv-api-lite/config \
  -v /root/iptv/output:/iptv-api-lite/output  \
  guovern/iptv-api:lite
```

### 查看运行日志

```docker
docker logs -f iptv
```

## 自动推送到 github

```docker
docker run -d \
  --name=iptv-push \
  --restart=unless-stopped \
  -v /root/iptv:/root/iptv \
  -e GIT_USERNAME="***" \
  -e GIT_EMAIL="***" \
  -e GIT_TOKEN="***" \
  -e GIT_REPO="github.com/***/***.git" \
  xiaotan666/iptv-push:latest
```

### 查看运行日志

```docker
docker logs -f iptv-push
```

### 相关配置文件备份

[config.ini](https://github.com/USYDShawnTan/iptv/blob/main/config/config.ini)

[demo.txt](https://github.com/USYDShawnTan/iptv/blob/main/config/demo.txt)

## 相关项目

### Guovin 大佬的 iptv-api

[地址](https://github.com/Guovin/iptv-api)

### 肥羊 allinone

[地址](https://pan.v1.mk/%E6%AF%8F%E6%9C%9F%E8%A7%86%E9%A2%91%E4%B8%AD%E7%94%A8%E5%88%B0%E7%9A%84%E6%96%87%E4%BB%B6%E5%88%86%E4%BA%AB/allinone%E4%BA%8C%E8%BF%9B%E5%88%B6%E6%96%87%E4%BB%B6/%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E.md)
