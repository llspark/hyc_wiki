#Install & Configurate postgresql

##install
`sudo apt-get install postgres`
##config
1. 每个实例可以多个db，每个db有自己的owner，每个db下可以建立多个schema，每个schema有自己的owner，每个schema下可以创建多张表，每张表都有自己的owner
2. db owner不一定能操作其下面的某个schema
3. schema owner不一定能操作其下面的某张表 
```
llblaze@llblaze:~$ sudo -u postgres psql
psql (10.12 (Ubuntu 10.12-0ubuntu0.18.04.1))
Type "help" for help.

postgres=# create user  hero with CREATEROLE password 'realhero';
CREATE ROLE
postgres=# create database vworld owner hero;
CREATE DATABASE
postgres=# grant all privileges on database vworld to hero;
GRANT
```
**注意：任何用户对public的schema都有all的权限，为了安全可以禁止用户对public schema**
**移除所有用户（public），superuser除外，对指定DB下的public schema的create 权限**
```
llblaze@llblaze:~$ sudo -u postgres psql -d vworld
vworld=# revoke  create  on schema public from public;
REVOKE
vworld=# grant create on schema public to hero;
GRANT
```
hero创建角色
```
llblaze@llblaze:~$ psql  -h 127.0.0.1  -p 5432  -U hero  -d vworld
Password for user hero: 
psql (10.12 (Ubuntu 10.12-0ubuntu0.18.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

vworld=> grant select,insert,delete,update on all tables in schema public to r_hero_dml;
GRANT
vworld=> grant select  on all tables in schema public to r_hero_qry;
GRANT
vworld=> create role r_hero_dml;
CREATE ROLE
vworld=> create role r_hero_qry;
GRANT ROLE
vworld=> create user herodata with login password 'herodata';
vworld=> grant r_hero_dml to herodata;
GRANT ROLE
vworld=> create user heroopr with login password 'heroopr';
vworld=> grant r_hero_dml to heroopr;
GRANT ROLE
vworld=> create user heroqry with login password 'heroqry';
vworld=> grant r_hero_qry to heroqry;
GRANT ROLE
```
data用户建表
```
llblaze@llblaze:~$ psql  -h 127.0.0.1  -p 5432  -U herodata  -d vworld
vworld=> create table user_info(user_id char(100),user_name char(100));
CREATE TABLE
qry和opr用户查询
```
llblaze@llblaze:~$ psql  -h 127.0.0.1  -p 5432  -U heroqry  -d vworld
vworld=> select * from user_info;
```
[^参考链接] https://www.cnblogs.com/zhoujinyi/p/10939715.html

