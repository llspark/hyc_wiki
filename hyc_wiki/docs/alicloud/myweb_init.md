# 阿里云使用记录

## 申请资源
* 1. 云主机：公网ip — 47.110.89.173
* 2. 域名：sweetsunshine.online 已和公网ip绑定


## 安装docker/tomcat
### 1. 添加yum源
```
> yum install epel-release –y
> yum clean all
> yum list
```
### 2. 安装docker
```
> yum install docker-io –y
> systemctl start docker
```
### 3. 检查docker
``> docker info``
### 4. 检索tomcat版本
```
> docker search tomcat
INDEX       NAME                                    DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
docker.io   docker.io/tomcat                        Apache Tomcat is an open source implementa...   2629      [OK]        
```
### 5. 下载tomcat镜像
```
> docker pull tomcat  
> docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/tomcat    latest              5692d26ea179        42 hours ago        507 MB
aliphpweb           v1                  e121d5f99e1e        3 years ago         448 MB
```
### 6. 启动tomcat  
```
> docker run --name myweb -d -p 8088:8080  5692d26ea179
> docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
8b8edcf5c880        docker.io/tomcat    "catalina.sh run"   6 minutes ago       Up 6 minutes        0.0.0.0:8088->8080/tcp   myweb
```

## 访问验证

### 1. tomcat镜像问题处理
curl http://localhost:8088/  返回404
``> docker exec -it e23f17a41176 /bin/bash``
发现tomcat目录下有两个webapps目录，
> webapps       # 目录是空的，删除  
> webapps.dist  # 目录有文件，替换名称为webapps，退出  

curl http://localhost:8088/ 访问成功  
重新生成镜像
```
> docker commit -a="heyc" -m="tomcat can access" 8b8edcf5c880 tomcat8:new
> docker ps
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
tomcat8             new                 7fb67216c045        About an hour ago   512 MB
docker.io/tomcat    latest              5692d26ea179        42 hours ago        507 MB
aliphpweb           v1                  e121d5f99e1e        3 years ago         448 MB
```
### 2. firewalld关闭
``> systemctl disable firewalld``  
### 3. 公网ip访问处理
浏览器输入公网ip，http://47.110.89.173:8080/ 无法访问  
在阿里云的控制台域名设置中，安全组规则配置，选择入方向，新增规则添加8080端口  
http://47.110.89.173:8080/访问正常  
http://www.sweetsunshine.online:8080/访问正常
***注意*** 端口改为80，直接用域名访问提示域名未备案。按照阿里备案流程操作即可，此处不详细展开说明。
