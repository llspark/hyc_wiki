# mkdcos 安装-发布-使用

## mkdocs介绍
mkdocs官网  
https://www.mkdocs.org/

## 安装环境
* 1 ubuntu 18.04
* 2 安装前提需要系统中先安装python和pip, 但系统存在python2和python3两个版本，注意命令区分  
``MkDocs supports Python versions 2.7, 3.4, 3.5, 3.6, 3.7 and pypy.``

## mkdocs安装
### 1. 安装python3
系统中已存在，采用python3版本  
``> python3 --version``
### 2. 安装pip3
* 1 切换到root用户下安装  
* 2 python对应的是pip，python3对应的是pip3  
``> sudo apt install python3-pip``

### 3. 安装mkdocs  mkdocs-material
* 1 要使用python3，pip3(python -m pip)  
``> python3 -m pip install mkdocs  mkdocs-material``
* 2 验证下是否安装成功  
``> mkdocs --version``

##mkdocs配置
### 1. 创建工作目录
```
> mkdocs new mkdocs_wiki
INFO    -  Creating project directory: mkdocs_wiki
INFO    -  Writing config file: mkdocs_wiki/mkdocs.yml    网站配置文件
INFO    -  Writing initial docs: mkdocs_wiki/docs/index.md   docs目录存放以后的文件
```

### 2. 启动mkdocs服务
进入工作目录  
```
> cd mkdocs_wiki  
> mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
[I 200201 16:39:48 server:283] Serving on http://127.0.0.1:8000
[I 200201 16:39:48 handlers:60] Start watching changes
[I 200201 16:40:13 handlers:133] Browser Connected: http://127.0.0.1:8000/
```  
可以本地登录http://127.0.0.1:8000/访问

### 3. 上传到github仓库托管
* 1 登录github创建一个仓库hyc_wiki
* 2 本地初始化仓库
```
> sudo apt-get install git
> git config --global user.email "********@163.com"    设置github账户信息
> git config --global user.name "*******"
> cd mkdocs_wiki
> echo "# hyc_wiki" >> README.md
> git init
> git add README.md
> git commit -m "first commit"
> git remote add origin https://github.com/llspark/hyc_wiki.git
> git push origin master
```  
如上把README.md上传到了github上  
若在github上修改了导致本地和远程的版本不一致，需要先pull同步下 
``git pull --rebase origin master``
若在新环境中搭建了mkdocs，要把原来的项目从线上拷贝下来，拷贝整个hyc_wiki目录
``> git clone  https://github.com/llspark/hyc_wiki``

### 4. 生成web站点
```
> mkdocs gh-deploy
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: /home/lblaze/mkdocs_wiki/site
INFO    -  Copying '/home/lblaze/mkdocs_wiki/site' to 'gh-pages' branch and pushing to GitHub.
Username for 'https://github.com': *******
Password for 'https://*******@github.com': *********
INFO    -  Your documentation should shortly be available at: https://llspark.github.io/hyc_wiki/
```
站点也同步到github，可通过https://github.com/llspark/hyc_wiki.git访问

## mkdocs 使用
### 1. 目录结构设置
目录设置主要通过mkdocs.yml来控制  
操作手册：https://mkdocs.readthedocs.io/en/stable/user-guide/configuration/  
***建议*** 参考英文文档，中文网站更新不及时
```
site_name: hyc_wiki
site_url:
repo_url: https://github.com/llspark/hyc_wiki
repo_name: GitHub
edit_uri: edit/master/docs/
site_description:
site_author: heyc
copyright:
google_analytics: ['UA-36723568-3', 'mkdocs.org']
remote_branch: gh-pages
remote_name: origin
nav:
    - 'Introduction': 'index.md'
    - 'UbuntuHomeSet':
         - 'mkdocs': 'ubuntu_homeset/app_mkdocs.md'
    - 'About':
         - 'ReadMe': 'about/ReadMe.md'
theme:
  name: material
docs_dir: docs
site_dir: site
extra_css:
extra_javascript:
extra_templates:
extra:
    version: 1.0
use_directory_urls: true
strict: false
dev_addr: 127.0.0.1:8000
markdown_extensions:
  - admonition
  - codehilite:
      guess_lang: false
      linenums: false
  - toc:
      permalink: true
  - footnotes
  - meta
  - def_list
  - pymdownx.arithmatex
  - pymdownx.betterem:
      smart_enable: all
  - pymdownx.caret
  - pymdownx.critic
  - pymdownx.details
  - pymdownx.emoji:
      emoji_generator: !!python/name:pymdownx.emoji.to_png
  - pymdownx.inlinehilite
  - pymdownx.magiclink
  - pymdownx.mark
  - pymdownx.smartsymbols
  - pymdownx.superfences
  - pymdownx.tasklist
  - pymdownx.tilde
plugins:
    - search:
        separator: '[\s\-\.]+'
```
### 2. 编辑md文件
* 1 md编辑工具  
安装atom软件，同时安装markdown相应的插件，具体可度娘
* 2 md格式  
markdown教程：https://www.runoob.com/markdown/md-paragraph.html
### 3. 同步到github
```
> git add *  #文件或目录
> git commit -m "# wiki1.0 commit"
> git push origin master
```
