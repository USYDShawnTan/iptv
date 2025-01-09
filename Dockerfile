# 使用基础镜像
FROM ubuntu:latest

# 设置工作目录
WORKDIR /root

# 安装必要的软件
RUN apt-get update && apt-get install -y \
    git \
    cron \
    && rm -rf /var/lib/apt/lists/*

# 设置时区为北京时间
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# 初始化仓库目录和 cron 日志文件
RUN mkdir -p /root/iptv && \
    touch /var/log/cron.log && chmod 666 /var/log/cron.log

# 将定时任务配置为每分钟执行
RUN echo '* * * * * cd /root/iptv && git add output/result.txt && git commit -m "Auto update $(date)" && git push origin main >> /var/log/cron.log 2>&1' | crontab -

# 启动容器时执行初始化脚本
CMD /bin/bash -c " \
    if [ ! -d /root/iptv/.git ]; then \
        echo 'Cloning repository...'; \
        git clone https://$GIT_TOK@$GIT_REPO /root/iptv; \
        cd /root/iptv; \
        git config --global user.name \"$GIT_USERNAME\"; \
        git config --global user.email \"$GIT_EMAIL\"; \
    fi; \
    echo 'Removing unnecessary files...'; \
    cd /root/iptv && rm -f Dockerfile README.md || true; \
    cron && tail -f /var/log/cron.log"