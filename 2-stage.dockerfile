FROM ubuntu:22.04 as initiator
WORKDIR /minecraft
RUN apt-get update && apt-get install -y openjdk-17-jre
ADD https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar /minecraft/server.jar
RUN timeout 60 java -jar /minecraft/server.jar --nogui

FROM gcr.io/distroless/java17-debian11 
# 工作目录
WORKDIR /minecraft

# 复制Minecraft服务器文件到容器
COPY --from=initiator /minecraft/server.jar .
COPY --from=initiator /minecraft/libraries libraries/
COPY --from=initiator /minecraft/versions versions/

# 设置默认启动命令
ENTRYPOINT [ "java" ]
CMD ["-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "--nogui"]

# 暴露默认的Minecraft端口
EXPOSE 25565