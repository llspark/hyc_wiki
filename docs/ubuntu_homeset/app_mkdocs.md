# mkdcos 安装部署

> mkdocs介绍
> >
> mkdocs官网
> > https://www.mkdocs.org/

> 安装环境
> > ubuntu 18.04
> > 安装前提需要系统中先安装python和pip, 但系统存在python2和python3两个版本，注意命令区分
MkDocs supports Python versions 2.7, 3.4, 3.5, 3.6, 3.7 and pypy.

## 安装python3
> 系统中已存在，采用python3版本
> > python3 --version
## 安装pip3
> 切换到root用户下安装
> python对应的是pip，python3对应的是pip3
> sudo apt install python3-pip

## 安装mkdocs  mkdocs-material
> 要使用python3，pip3(python -m pip)
> python3 -m pip install mkdocs  mkdocs-material
> mkdocs --version 验证下是否安装成功

## 1. 创建工作目录
```
mkdocs new mkdocs_wiki
INFO    -  Creating project directory: mkdocs_wiki
INFO    -  Writing config file: mkdocs_wiki/mkdocs.yml    网站配置文件
INFO    -  Writing initial docs: mkdocs_wiki/docs/index.md   docs目录存放以后的文件
```

## 2. 进入工作目录后启动mkdocs服务
```
cd mkdocs_wiki  
mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
[I 200201 16:39:48 server:283] Serving on http://127.0.0.1:8000
[I 200201 16:39:48 handlers:60] Start watching changes
[I 200201 16:40:13 handlers:133] Browser Connected: http://127.0.0.1:8000/
```
> 可以本地登录http://127.0.0.1:8000/访问

## 3. 上传到github仓库托管
> 登录github创建一个仓库hyc_wiki
> 本地初始化仓库
```
cd mkdocs_wiki
echo "# hyc_wiki" >> README.md
git init
git add README.md
git config --global user.email "hyc8711@163.com"    设置github账户信息
git config --global user.name "hyc8711@163.com"
git commit -m "first commit"
git remote add origin https://github.com/llspark/hyc_wiki.git
git push origin master
```
> 如上把README.md上传到了github上
> 若在github上修改了导致本地和远程的版本不一致，需要先pull同步下 git pull --rebase origin master

## 4. 生成web站点
```
mkdocs gh-deploy
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: /home/lblaze/mkdocs_wiki/site
INFO    -  Copying '/home/lblaze/mkdocs_wiki/site' to 'gh-pages' branch and pushing to GitHub.
Username for 'https://github.com': hyc8711@163.com
Password for 'https://hyc8711@163.com@github.com': 87pipal&*
INFO    -  Your documentation should shortly be available at: https://llspark.github.io/hyc_wiki/
```
> 站点也同步到github，可通过https://github.com/llspark/hyc_wiki.git访问
