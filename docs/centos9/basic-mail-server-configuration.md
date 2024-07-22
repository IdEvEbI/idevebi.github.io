# CentOS 9 实战（14）：邮件服务器基础配置

欢迎来到《CentOS 9 实战速查手册》专栏的第 14 篇文章。在这里，我们将探讨 **CentOS 9** 中的 **邮件服务器基础配置**。邮件服务器是企业和开发者常用的服务之一，通过学习它的配置，你将能够为你的组织或项目提供可靠的邮件通信服务。在本篇文章中，我们将介绍如何安装和配置 **Postfix** 和 **Dovecot**，并结合 **Roundcube** 提供 Webmail 界面。

## 1. 安装和配置 Postfix

**Postfix** 是一款广泛使用的开源邮件传输代理（MTA），用于发送和接收邮件。

### 1.1 安装 Postfix

首先，使用以下命令安装 **Postfix**：

```sh
sudo dnf install -y postfix
```

### 1.2 启动和启用 Postfix 服务

安装完成后，启动 **Postfix** 服务并设置为开机自启：

```sh
sudo systemctl start postfix
sudo systemctl enable postfix
```

### 1.3 配置 Postfix

编辑 **Postfix** 配置文件 `/etc/postfix/main.cf`，确保以下配置项已设置：

```sh
# 设置主机名
myhostname = mail.your_domain.com

# 设置邮件域
mydomain = your_domain.com

# 设置邮件接收域
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

# 设置网络接口
inet_interfaces = all

# 设置允许的网络
mynetworks = 127.0.0.0/8

# 设置邮件箱大小限制（可选）
mailbox_size_limit = 0

# 设置最大邮件大小（可选）
message_size_limit = 10485760

# 设置本地邮件传递代理
local_recipient_maps = unix:passwd.byname $alias_maps
```

保存并退出编辑器，然后重启 **Postfix** 服务以使更改生效：

```sh
sudo systemctl restart postfix
```

### 1.4 配置防火墙

允许邮件服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-service=smtp
sudo firewall-cmd --reload
```

## 2. 安装和配置 Dovecot

**Dovecot** 是一款开源的 IMAP 和 POP3 服务器，用于接收和存储邮件。

### 2.1 安装 Dovecot

使用以下命令安装 **Dovecot**：

```sh
sudo dnf install -y dovecot
```

### 2.2 启动和启用 Dovecot 服务

安装完成后，启动 **Dovecot** 服务并设置为开机自启：

```sh
sudo systemctl start dovecot
sudo systemctl enable dovecot
```

### 2.3 配置 Dovecot

编辑 **Dovecot** 配置文件 `/etc/dovecot/dovecot.conf`，确保以下配置项已设置：

```sh
# 启用 IMAP 和 POP3 协议
protocols = imap pop3 lmtp

# 设置邮件位置
mail_location = maildir:~/Maildir

# 设置认证机制
auth_mechanisms = plain login

# 启用用户认证
userdb {
  driver = passwd
}
passdb {
  driver = pam
}
```

保存并退出编辑器，然后重启 **Dovecot** 服务以使更改生效：

```sh
sudo systemctl restart dovecot
```

### 2.4 配置防火墙

允许 IMAP 和 POP3 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-service=imap
sudo firewall-cmd --permanent --add-service=pop3
sudo firewall-cmd --reload
```

## 3. 安装和配置 Roundcube

**Roundcube** 是一个开源的 Webmail 客户端，用于提供基于浏览器的邮件访问界面。

### 3.1 安装 Apache 和 PHP

首先，安装 **Apache** 和 **PHP**：

```sh
sudo dnf install -y httpd php php-mysqlnd php-imap php-xml php-mbstring php-json php-gd
```

### 3.2 启动和启用 Apache 服务

安装完成后，启动 **Apache** 服务并设置为开机自启：

```sh
sudo systemctl start httpd
sudo systemctl enable httpd
```

### 3.3 下载并安装 Roundcube

下载 **Roundcube** 安装包并解压：

```sh
wget https://github.com/roundcube/roundcubemail/releases/download/1.5.2/roundcubemail-1.5.2-complete.tar.gz
tar -zxvf roundcubemail-1.5.2-complete.tar.gz
sudo mv roundcubemail-1.5.2 /var/www/html/roundcube
sudo chown -R apache:apache /var/www/html/roundcube
```

### 3.4 配置 Roundcube

复制配置文件模板并编辑配置文件：

```sh
cd /var/www/html/roundcube/config
cp config.inc.php.sample config.inc.php
sudo vim config.inc.php
```

在配置文件中，确保以下配置项已设置：

```php
$config['db_dsnw'] = 'mysql://roundcube_user:password@localhost/roundcube_db';
$config['default_host'] = 'localhost';
$config['smtp_server'] = 'localhost';
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';
$config['support_url'] = 'http://your_domain/roundcube';
$config['product_name'] = 'Roundcube Webmail';
```

### 3.5 设置 Roundcube 数据库

创建 Roundcube 数据库并导入初始表结构：

```sh
sudo mysql -u root -p
CREATE DATABASE roundcube;
CREATE USER 'roundcube_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

cd /var/www/html/roundcube/SQL
mysql -u roundcube_user -p roundcube < mysql.initial.sql
```

### 3.6 配置防火墙

允许 HTTP 和 HTTPS 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

### 3.7 访问 Roundcube

在浏览器中访问 **Roundcube** Webmail 界面：

```bash
http://your_domain/roundcube
```

## 4. 总结

在这篇文章中，我们介绍了 **CentOS 9** 中的 **邮件服务器基础配置**，包括 **Postfix** 和 **Dovecot** 的安装与配置，并结合 **Roundcube** 提供 Webmail 界面。通过掌握这些知识，你可以为你的组织或项目提供可靠的邮件通信服务。在接下来的文章中，我们将深入探讨 **KVM 虚拟化与管理**，敬请期待。
