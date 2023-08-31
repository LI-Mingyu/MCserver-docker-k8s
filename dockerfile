FROM gcr.io/distroless/java17-debian11 
# 工作目录
WORKDIR /minecraft

# 复制Minecraft服务器文件到容器
COPY server.jar .
COPY libraries libraries/
COPY versions versions/
COPY server.properties .
COPY eula.txt .

# 设置默认启动命令
ENTRYPOINT [ "java" ]
CMD ["-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "--nogui"]

# 暴露默认的Minecraft端口
EXPOSE 25565