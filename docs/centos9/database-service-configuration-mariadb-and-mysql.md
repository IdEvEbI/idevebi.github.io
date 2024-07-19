# CentOS 9 实战（11）：数据库服务配置之 MySQL 与 MariaDB

欢迎来到《CentOS 9 实战速查手册》专栏的第 11 篇文章。在这里，我们将探讨 **CentOS 9** 中的 **数据库服务配置**，重点介绍 **MariaDB** 和 **MySQL** 的安装与配置。这两种数据库在现代应用开发中占据重要地位，通过学习它们的配置，你将能够为你的应用程序提供高效、可靠的数据库服务。

## 1. MariaDB 与 MySQL 对比

在选择数据库时，了解 **MariaDB** 和 **MySQL** 的特点、优势和劣势是非常重要的。

### 1.1 MariaDB

- **优势**：
  - **开源**：MariaDB 完全开源，没有商业版本和社区版本的区分。
  - **性能优化**：在某些场景下，MariaDB 对性能进行了优化，提供了更高的性能。
  - **兼容性**：MariaDB 兼容 MySQL，可以无缝替换 MySQL 使用。

- **劣势**：
  - **社区支持**：虽然 MariaDB 社区活跃，但在某些特定场景下，可能没有 MySQL 那么广泛的社区支持。

### 1.2 MySQL

- **优势**：
  - **广泛应用**：MySQL 是最流行的开源数据库之一，被广泛应用于各种应用场景。
  - **丰富的功能**：MySQL 提供了丰富的功能和插件，满足不同需求。
  - **企业支持**：MySQL 提供企业版，拥有官方的技术支持和服务。

- **劣势**：
  - **商业化**：MySQL 有商业版和社区版之分，有些高级功能需要商业授权。

### 1.3 选择建议

在选择 MariaDB 和 MySQL 时，可以根据以下建议：

- 如果你希望使用完全开源的数据库，并且不需要企业版的高级功能，可以选择 **MariaDB**。
- 如果你需要 MySQL 的企业支持或某些特定功能，可以选择 **MySQL**。

## 2. 安装 MySQL

### 2.1 配置 MySQL YUM 仓库

首先，需要配置 MySQL YUM 仓库：

```sh
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
```

### 2.2 安装 MySQL

然后，安装 MySQL：

```sh
sudo dnf install -y mysql-server --nogpgcheck
```

### 2.3 启动 MySQL 服务

安装完成后，启动 MySQL 服务并设置为开机自启：

```sh
sudo systemctl start mysqld
sudo systemctl enable mysqld
```

### 2.4 获取初始 root 密码

MySQL 安装完成后，会生成一个初始 root 密码，可以通过以下命令查看：

```sh
sudo grep 'temporary password' /var/log/mysqld.log
```

### 2.5 配置 MySQL

使用初始密码登录 MySQL 并进行配置：

```sh
mysql_secure_installation
```

按照提示设置新密码，并进行安全配置。

### 2.6 创建远程用户

登录 MySQL 并创建远程用户：

```sh
mysql -u root -p

# 在 MySQL 控制台中执行
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'remote_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### 2.7 配置防火墙

允许 MySQL 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-port=3306/tcp
sudo firewall-cmd --reload
```

### 2.8 配置 MySQL 允许远程连接

编辑 MySQL 配置文件 `/etc/my.cnf`，添加或修改以下内容：

```sh
[mysqld]
bind-address=0.0.0.0
```

### 2.9 重启 MySQL 服务

配置完成后，重启 MySQL 服务：

```sh
sudo systemctl restart mysqld
```

### 2.10 远程连接测试

在本地或其他服务器上使用 MySQL 客户端工具连接 MySQL 服务器：

```sh
mysql -u remote_user -p -h your_server_ip
```

## 3. 安装和配置 phpMyAdmin

### 3.1 安装 phpMyAdmin

首先，在服务器上安装 phpMyAdmin：

```sh
sudo dnf install -y epel-release
sudo dnf install -y phpmyadmin
```

### 3.2 配置 Nginx

编辑 Nginx 配置文件 `/etc/nginx/conf.d/default.conf`：

```nginx
server {
    listen       80;
    server_name  your_domain;

    root   /usr/share/nginx/html;
    index  index.php index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    location /phpmyadmin {
        alias /usr/share/phpMyAdmin;
        index index.php;
        
        location ~ ^/phpmyadmin/(.+\.php)$ {
            try_files $uri =404;
            fastcgi_pass unix:/run/php-fpm/www.sock;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            include fastcgi_params;
        }

        location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt|svg|ttf|woff|woff2))$ {
            alias /usr/share/phpMyAdmin/$1;
            access_log off;
            log_not_found off;
            expires max;
        }
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

### 3.3 检查 PHP-FPM 配置

确保 `/etc/php-fpm.d/www.conf` 文件中 `user` 和 `group` 设置为 `nginx`：

```sh
; Unix user/group of processes
user = nginx
group = nginx
```

### 3.4 修改会话目录权限

确保会话目录 `/var/lib/php/session` 具有正确的权限：

```sh
sudo chown -R nginx:nginx /var/lib/php/session
sudo chmod -R 700 /var/lib/php/session
```

### 3.5 重启服务

重新加载 Nginx 配置并重启相关服务：

```sh
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl restart php-fpm
```

### 3.6 验证配置

创建一个 PHP 测试文件来验证 PHP 和 Nginx 配置是否正确：

```sh
echo "<?php phpinfo(); ?>" | sudo tee /usr/share/nginx/html/info.php
```

在浏览器中访问 `http://your_domain/info.php`，确保 PHP 信息页面正常显示。

### 3.7 验证 phpMyAdmin

在浏览器中访问 `http://your_domain/phpmyadmin`，确保可以正确加载 phpMyAdmin 页面。

## 4. 安装 MariaDB

### 4.1 配置 MariaDB YUM 仓库

首先，需要配置 MariaDB YUM 仓库：

```sh
sudo dnf install -y https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
```

### 4.2 安装 MariaDB

然后，安装 MariaDB：

```sh
sudo dnf install -y mariadb-server
```

### 4.3 启动 MariaDB 服务

安装完成后，启动 MariaDB 服务并设置为开机自启：

```sh
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

### 4.4 配置 MariaDB

使用以下命令进行安全配置：

```sh
mysql_secure_installation
```

按照提示设置新密码，并进行安全配置。

### 4.5 创建远程用户

登录 MariaDB 并创建远程用户：

```sh
mysql -u root -p

# 在 MariaDB 控制台中执行
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'remote_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### 4.6 配置防火墙

允许 MariaDB 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-port=3306/tcp
sudo firewall-cmd --reload
```

### 4.7 配置 MariaDB 允许远程连接

编辑 MariaDB 配置文件 `/etc/my.cnf.d/mariadb-server.cnf`，添加或修改以下内容：

```sh
[mysqld]
bind-address=0.0.0.0
```

### 4.8 重启 MariaDB 服务

配置完成后，重启 MariaDB 服务：

```sh
sudo systemctl restart mariadb
```

### 4.9 远程连接测试

在本地或其他服务器

上使用 MySQL 客户端工具连接 MariaDB 服务器：

```sh
mysql -u remote_user -p -h your_server_ip
```

## 5. 总结

在这篇文章中，我们详细介绍了 **MariaDB** 和 **MySQL** 的安装与配置。我们对比了这两种数据库的特点和选择建议，随后分别介绍了 **MySQL** 和 **MariaDB** 的安装、配置及远程连接设置。此外，还介绍了如何在 **Nginx** 服务器上安装和配置 **phpMyAdmin**，方便管理和操作数据库。在接下来的文章中，我们将深入探讨 **FTP 与 SFTP 服务配置**，敬请期待。
