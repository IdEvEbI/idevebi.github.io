# CentOS 9 实战（10）：Web 服务器配置：Apache 与 Nginx

欢迎来到《CentOS 9 实战速查手册》专栏的第 10 篇文章。在这里，我们将探讨 **CentOS 9** 中的 **Web 服务器配置**，重点介绍 **Apache** 和 **Nginx** 的安装与配置。这两种 Web 服务器在现代 Web 开发中占据重要地位，通过学习它们的配置，你将能够为你的应用程序提供高效、可靠的 Web 服务。

## 1. Apache 与 Nginx 对比

在选择 Web 服务器时，了解 **Apache** 和 **Nginx** 的特点、优势和劣势是非常重要的。

### 1.1 Apache

- **优势**：

  - **模块化设计**：Apache 具有丰富的模块，用户可以根据需求加载或卸载模块，灵活性高。
  - **广泛的兼容性**：Apache 支持多种操作系统和编程语言，适用于各种开发环境。
  - **强大的社区支持**：作为最早的 Web 服务器之一，Apache 拥有庞大的用户群体和社区支持。

- **劣势**：

  - **性能瓶颈**：在高并发和高流量的场景下，Apache 的性能可能不如 Nginx。
  - **资源占用**：Apache 在处理大量并发请求时，占用的系统资源较多。

### 1.2 Nginx

- **优势**：

  - **高性能**：Nginx 采用事件驱动架构，能够高效处理大量并发请求，性能优异。
  - **低资源占用**：Nginx 在高并发场景下的资源占用相对较低。
  - **反向代理和负载均衡**：Nginx 内置了强大的反向代理和负载均衡功能，非常适合微服务架构和分布式系统。

- **劣势**：

  - **配置复杂**：Nginx 的配置文件相对复杂，对新手来说可能有一定的学习曲线。
  - **模块支持**：与 Apache 相比，Nginx 的模块数量较少，某些特定功能可能需要自行开发或寻找第三方模块。

### 1.3 开发中的主流建议

在选择 Web 服务器时，开发者需要根据具体需求来选择合适的服务器：

- **静态内容服务**：**Nginx** 通常被推荐用于静态内容服务（如 HTML、CSS、JavaScript、图片等），因为其性能优异，资源占用低。
- **动态内容服务**：**Apache** 在处理动态内容（如 PHP、Python、Perl 等）时有较好的兼容性和支持。
- **混合环境**：在现代 Web 开发中，很多企业选择将 **Nginx** 作为前端代理服务器，处理静态内容和反向代理请求，而将 **Apache** 用作后端服务器，处理动态内容。这种组合可以充分利用两者的优势，提供高效、可靠的 Web 服务。

### 1.4 企业开发的最佳实践

- **性能优化**：无论选择 **Apache** 还是 **Nginx**，都应进行性能优化，包括配置优化、缓存设置和资源压缩等。
- **安全性**：定期更新服务器软件，配置 HTTPS，使用防火墙和访问控制列表（ACL）来保护服务器安全。
- **监控和日志**：配置监控和日志系统，及时发现和处理问题，确保服务器稳定运行。
- **高可用性**：配置负载均衡和集群，确保高可用性，避免单点故障。

## 2. 安装与配置 Apache

### 2.1 安装 Apache

在 **CentOS 9** 中，可以使用 **`dnf`** 命令来安装 **Apache**（**httpd**）：

```sh
# 安装 Apache
sudo dnf install -y httpd
```

### 2.2 启动和启用 Apache 服务

安装完成后，需要启动 **Apache** 服务并设置为开机自启：

```sh
# 启动 Apache 服务
sudo systemctl start httpd

# 启用 Apache 服务，系统启动时自动启动
sudo systemctl enable httpd
```

### 2.3 检查 Apache 服务状态

使用以下命令检查 **Apache** 服务的运行状态：

```sh
# 检查 Apache 服务状态
sudo systemctl status httpd
```

### 2.4 配置防火墙

确保防火墙允许 **HTTP** 和 **HTTPS** 流量：

```sh
# 允许 HTTP 流量
sudo firewall-cmd --permanent --add-service=http

# 允许 HTTPS 流量
sudo firewall-cmd --permanent --add-service=https

# 重新加载防火墙规则
sudo firewall-cmd --reload
```

### 2.5 配置虚拟主机

通过配置虚拟主机，可以在一台服务器上托管多个网站。虚拟主机配置文件位于 **`/etc/httpd/conf.d`** 目录下。以下是一个简单的虚拟主机配置示例：

```sh
# 创建虚拟主机配置文件
sudo vim /etc/httpd/conf.d/your_site.conf

# 添加以下内容
<VirtualHost *:80>
    ServerName your_site.com
    DocumentRoot /var/www/your_site

    <Directory /var/www/your_site>
        Options Indexes FollowSymLinks Includes
        AllowOverride All
        Require all granted

        # 支持 .shtml 文件作为索引文件
        DirectoryIndex index.html index.htm index.shtml
    </Directory>

    ErrorLog /var/log/httpd/your_site_error.log
    CustomLog /var/log/httpd/your_site_access.log combined
</VirtualHost>
```

### 2.6 创建网站目录和权限

创建网站目录并设置适当的权限：

```sh
# 创建网站目录
sudo mkdir -p /var/www/your_site

# 设置目录权限
sudo chown -R apache:apache /var/www/your_site
```

### 2.7 重启 Apache 服务

配置完成后，重启 **Apache** 服务以使更改生效：

```sh
# 重启 Apache 服务
sudo systemctl restart httpd
```

### 2.8 测试 Apache 和 SSI 配置

1. **创建一个 `index.shtml` 文件**：

    ```sh
    echo '<html><body><h1>Welcome to your_site.com!</h1><!--#echo var="DATE_LOCAL" --></body></html>' | sudo tee /var/www/your_site/index.shtml
    ```

2. **在浏览器中访问你的虚拟主机域名**：

    ```sh
    http://your_site.com
    ```

    你应该能够看到 `index.shtml` 页面，并且服务器端包含的指令（如 `<!--#echo var="DATE_LOCAL" -->`）应该被正确解析和显示。

## 3. 安装与配置 Nginx

### 3.1 安装 Nginx

在 **CentOS 9** 中，可以使用 **`dnf`** 命令来安装 **Nginx**：

```sh
# 安装 Nginx
sudo dnf install -y nginx
```

### 3.2 启动和启用 Nginx 服务

安装完成后，需要启动 **Nginx** 服务并设置为开机自启：

```sh
# 启动 Nginx 服务
sudo systemctl start nginx

# 启用 Nginx 服务，系统启动时自动启动
sudo systemctl enable nginx
```

### 3.3 检查 Nginx 服务状态

使用以下命令检查 **Nginx** 服务的运行状态：

```sh
# 检查 Nginx 服务状态
sudo systemctl status nginx
```

### 3.4 配置防火墙

确保防火墙允许 **HTTP** 和 **HTTPS** 流量：

```sh
# 允许 HTTP 流量
sudo firewall-cmd --permanent --add-service=http

# 允许 HTTPS 流量
sudo firewall-cmd --permanent --add-service=https

# 重新加载防火墙规则
sudo firewall-cmd --reload
```

### 3.5 配置服务器块

通过配置服务器块，可以在一台服务器上托管多个网站。服务器块配置文件位于 **`/etc/nginx/conf.d`** 目录下。以下是一个简单的服务器块配置示例：

```sh
# 创建服务器块配置文件
sudo vim /etc/nginx/conf.d/your_site.conf

# 添加以下内容
server {
    listen 80;
    server_name your_site.com;
    root /var/www/your_site;

    index index.html index.htm index.shtml;

    location / {
        try_files $uri $uri/ =404;
    }

    error_log /var/log/nginx/your_site_error.log;
    access_log /var/log/nginx/your_site_access.log;
}


```

### 3.6 创建网站目录和权限

创建网站目录并设置适当的权限：

```sh
# 创建网站目录
sudo mkdir -p /var/www/your_site

# 设置目录权限
sudo chown -R nginx:nginx /var/www/your_site
```

### 3.7 启用 SSI 模块

在 Nginx 配置文件中启用 **SSI** 模块：

```sh
# 编辑 Nginx 配置文件
sudo vim /etc/nginx/nginx.conf

# 在 http 块或 server 块中添加 ssi on 指令
http {
    ...
    ssi on;
    ...
}
```

### 3.8 重启 Nginx 服务

配置完成后，重启 **Nginx** 服务以使更改生效：

```sh
# 重启 Nginx 服务
sudo systemctl restart nginx
```

### 3.9 测试 Nginx 和 SSI 配置

1. **创建一个 `index.shtml` 文件**：

    ```sh
    echo '<html><body><h1>Welcome to your_site.com!</h1><!--#echo var="DATE_LOCAL" --></body></html>' | sudo tee /var/www/your_site/index.shtml
    ```

2. **在浏览器中访问你的虚拟主机域名**：

    ```sh
    http://your_site.com
    ```

    你应该能够看到 `index.shtml` 页面，并且服务器端包含的指令（如 `<!--#echo var="DATE_LOCAL" -->`）应该被正确解析和显示。

## 4. 配置 HTTPS

为了确保数据在传输过程中安全，加密 Web 流量是非常重要的。可以使用 **Let's Encrypt** 提供的免费 **SSL 证书** 来配置 **HTTPS**。

### 4.1 安装 Certbot

**Certbot** 是一个用于自动化 SSL 证书生成和管理的工具。可以使用以下命令安装 **Certbot**：

```sh
# 安装 Certbot
sudo dnf install -y certbot python3-certbot-apache python3-certbot-nginx
```

### 4.2 使用 Certbot 配置 Apache HTTPS

使用 **Certbot** 自动配置 **Apache** 的 **HTTPS**：

```sh
# 使用 Certbot 配置 Apache HTTPS
sudo certbot --apache
```

按照提示操作，Certbot 将自动生成 SSL 证书并配置 **Apache** 使用 HTTPS。

### 4.3 使用 Certbot 配置 Nginx HTTPS

使用 **Certbot** 自动配置 **Nginx** 的 **HTTPS**：

```sh
# 使用 Certbot 配置 Nginx HTTPS
sudo certbot --nginx
```

按照提示操作，Certbot 将自动生成 SSL 证书并配置 **Nginx** 使用 HTTPS。

### 4.4 自动续约 SSL 证书

Let's Encrypt 的 SSL 证书有效期为 90 天，建议配置自动续约：

```sh
# 配置自动续约
sudo certbot renew --dry-run
```

确保 **Certbot** 的自动续约功能正常工作。

## 5. 同时安装 Apache 和 Nginx 的端口冲突问题

当在同一台服务器上同时安装 **Apache** 和 **Nginx** 时，可能会出现端口冲突问题。默认情况下，两者都监听 **80** 和 **443** 端口。

### 5.1 修改 Apache 端口

可以修改 **Apache** 的端口配置，避免与 **Nginx** 冲突：

```sh
# 编辑 Apache 主配置文件
sudo vim /etc/httpd/conf/httpd.conf

# 修改监听端口
Listen 8080
```

然后重启 **Apache** 服务：

```sh
# 重启 Apache 服务
sudo systemctl restart httpd
```

### 5.2 修改 Nginx 端口

也可以修改 **Nginx** 的端口配置，避免与 **Apache** 冲突：

```sh
# 编辑 Nginx 配置文件
sudo vim /etc/nginx/nginx.conf

# 修改监听端口
server {
    listen 8080;
    ...
}
```

然后重启 **Nginx** 服务：

```sh
# 重启 Nginx 服务
sudo systemctl restart nginx
```

## 6. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的 **Web 服务器配置**，包括 **Apache** 和 **Nginx** 的安装与配置，如何配置 HTTPS，以及如何解决两者同时安装时的端口冲突问题。通过掌握这些知识，你可以为你的应用程序提供高效、可靠、安全的 Web 服务。在接下来的文章中，我们将深入探讨 **数据库服务配置：MariaDB 与 MySQL**，敬请期待。
