# CentOS 9 实战（10）：SSH 服务配置与使用

欢迎来到《CentOS 9 实战速查手册》专栏的第 10 篇文章。在这里，我们将深入探讨 **CentOS 9** 中的 **SSH 服务配置与使用**。**SSH**（Secure Shell）是用于在不安全网络上进行安全通信和远程管理的网络协议。通过正确配置 **SSH 服务**，你可以提高系统的安全性和管理效率。

## 1. 确认和启动 SSH 服务

在 **CentOS 9** 中，系统安装完成后默认支持 **SSH 登录**，但我们需要确认 **OpenSSH** 服务是否已安装和启动。

### 1.1 确认 OpenSSH

在大多数情况下，**CentOS 9** 默认安装了 **OpenSSH**。如果你在极少数情况下发现未安装，可以使用以下命令安装：

```sh
# 确认 OpenSSH 安装
rpm -q openssh-server

# 如果未安装，则安装 OpenSSH
sudo dnf install -y openssh-server
```

### 1.2 启动和启用 SSH 服务

确认安装后，你需要确保 **SSH 服务** 已启动并设置为开机自启：

```sh
# 启动 SSH 服务
sudo systemctl start sshd

# 启用 SSH 服务
sudo systemctl enable sshd
```

### 1.3 检查 SSH 服务状态

你可以使用以下命令检查 **SSH 服务** 的运行状态：

```sh
# 检查 SSH 服务状态
sudo systemctl status sshd
```

## 2. 配置 SSH 服务

**SSH 服务** 的配置文件位于 **`/etc/ssh/sshd_config`**。你可以通过编辑此文件来配置 **SSH 服务**。

### 2.1 修改默认端口

为了提高安全性，可以修改 **SSH 服务** 的默认端口（22）：

```sh
# 编辑 SSH 配置文件
sudo vim /etc/ssh/sshd_config

# 将以下行的端口号改为你想使用的端口号（如 2222）
#Port 22
Port 2222
```

保存并退出编辑器，然后重启 **SSH 服务** 以使更改生效：

```sh
# 重启 SSH 服务
sudo systemctl restart sshd
```

### 2.2 禁用 Root 登录

为了提高系统安全性，建议禁用 **root** 用户通过 **SSH 登录**：

```sh
# 编辑 SSH 配置文件
sudo vim /etc/ssh/sshd_config

# 将以下行的 PermitRootLogin 值改为 no
#PermitRootLogin yes
PermitRootLogin no
```

保存并退出编辑器，然后重启 **SSH 服务** 以使更改生效：

```sh
# 重启 SSH 服务
sudo systemctl restart sshd
```

### 2.3 配置密钥认证

使用 **密钥认证** 可以提高 **SSH 登录** 的安全性。以下是配置步骤：

#### 生成 SSH 密钥对

在客户端机器上生成 **SSH 密钥对**：

```sh
# 生成 SSH 密钥对
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

按照提示操作，生成的公钥文件通常位于 **`~/.ssh/id_rsa.pub`**。

#### 将公钥添加到服务器

使用以下步骤将客户端生成的公钥添加到 **CentOS 服务器** 上，并限制用户只能通过密钥对访问：

- 在客户端机器上，将公钥复制到服务器：

```sh
# 在客户端机器上，将公钥复制到服务器
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server_address
```

- 如果 **ssh-copy-id** 命令不可用，你可以手动将公钥复制到服务器：

```sh
# 显示公钥内容
cat ~/.ssh/id_rsa.pub

# 在服务器上，将公钥内容添加到 ~/.ssh/authorized_keys 文件
echo "公钥内容" >> ~/.ssh/authorized_keys
```

#### 禁用密码认证

为了进一步提高安全性，可以禁用密码认证，只允许使用 **密钥认证**：

```sh
# 编辑 SSH 配置文件
sudo vim /etc/ssh/sshd_config

# 将以下行的 PasswordAuthentication 值改为 no
#PasswordAuthentication yes
PasswordAuthentication no
```

保存并退出编辑器，然后重启 **SSH 服务** 以使更改生效：

```sh
# 重启 SSH 服务
sudo systemctl restart sshd
```

## 3. 使用 SSH 进行远程管理

### 3.1 连接到远程服务器

使用 **SSH** 连接到远程服务器：

```sh
# 使用 SSH 连接到远程服务器
ssh user@server_address
```

如果你修改了 **SSH 服务** 的默认端口，需要指定端口号：

```sh
# 使用指定端口连接到远程服务器
ssh -p 2222 user@server_address
```

### 3.2 传输文件

使用 **`scp`** 命令通过 **SSH** 传输文件：

```sh
# 将本地文件传输到远程服务器
scp /path/to/local/file user@server_address:/path/to/remote/directory

# 将远程服务器的文件传输到本地
scp user@server_address:/path/to/remote/file /path/to/local/directory
```

### 3.3 使用 SSH 隧道

**SSH 隧道** 是一种通过 **SSH** 创建加密通道的方法，用于在不安全的网络上安全地传输数据。它可以实现本地端口转发和远程端口转发。

#### 本地端口转发

本地端口转发用于将本地计算机的端口流量转发到远程服务器的端口。例如，你希望将本地端口 **8080** 的流量通过 **SSH 隧道** 转发到远程服务器的 **80** 端口：

```sh
# 使用 SSH 隧道进行本地端口转发
ssh -L 8080:localhost:80 user@server_address
```

在上述命令中，任何发送到本地端口 **8080** 的流量都会被加密并通过 **SSH 隧道** 转发到远程服务器的 **80** 端口。

#### 远程端口转发

远程端口转发用于将远程服务器的端口流量转发到本地计算机的端口。例如，你希望将远程服务器的端口 **8080** 的流量通过 **SSH 隧道** 转发到本地计算机的 **80** 端口：

```sh
# 使用 SSH 隧道进行远程端口转发
ssh -R 8080:localhost:80 user@server_address
```

在上述命令中，任何发送到远程服务器端口 **8080** 的流量都会被加密并通过 **SSH 隧道** 转发到本地计算机的 **80** 端口。

## 4. SSH 服务的安全性最佳实践

为了确保 **SSH 服务** 的安全性，建议遵循以下最佳实践：

### 4.1 使用强密码和密钥认证

始终使用强密码，并尽可能使用 **密钥认证** 以提高安全性。

### 4.2 限制登录用户

通过编辑 **`/etc/ssh/sshd_config`** 文件，使用 **`AllowUsers`** 或 **`AllowGroups`** 指令限制可以通过 **SSH 登录** 的用户：

```sh
# 只允许特定用户通过 SSH 登录
AllowUsers user1 user2

# 或只允许特定组的用户通过 SSH 登录
AllowGroups sshusers
```

### 4.3 启用防火墙

使用 **`firewalld`** 或 **`iptables`** 启用防火墙并配置规则以限制 **SSH 访问**：

```sh
# 启用并配置 firewalld 以允许 SSH 访问
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

### 4.4 启用 Fail2Ban

**Fail2Ban** 可以帮助保护 **SSH 服务** 免受暴力破解攻击：

```sh
# 安装 Fail2Ban
sudo dnf install -y fail2ban

# 启动并启用 Fail2Ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# 配置 Fail2Ban 以保护 SSH 服务
sudo vim /etc/fail2ban/jail.local

# 添加以下内容
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
maxretry = 5
```

保存并退出编辑器，然后重启 **Fail2Ban 服务**：

```sh
# 重启 Fail2Ban 服务
sudo systemctl restart fail2ban
```

## 5. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的 **SSH 服务配置与使用**，包括 **SSH 服务** 的确认、启动、配置和安全性最佳实践。我们还详细讲解了 **SSH 隧道** 的工作原理和

使用方法。通过掌握这些知识，你可以提高系统的安全性和管理效率。在接下来的文章中，我们将深入探讨 **Web 服务器配置：Apache 与 Nginx**，敬请期待。
