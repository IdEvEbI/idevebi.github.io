# CentOS 9 实战（12）：FTP 与 SFTP 服务配置

欢迎来到《CentOS 9 实战速查手册》专栏的第 12 篇文章。在这里，我们将探讨 **CentOS 9** 中的 **FTP 与 SFTP 服务配置**。FTP（File Transfer Protocol）和 SFTP（SSH File Transfer Protocol）是两种常见的文件传输协议，通过学习它们的配置，你将能够为你的服务器提供高效、安全的文件传输服务。

## 1. FTP 与 SFTP 对比

在选择文件传输协议时，了解 **FTP** 和 **SFTP** 的特点、优势和劣势是非常重要的。

### 1.1 FTP

- **优势**：
  - **简单易用**：FTP 协议简单，使用方便。
  - **广泛支持**：大多数操作系统和文件传输工具都支持 FTP。

- **劣势**：
  - **安全性差**：FTP 以明文传输数据，容易被窃听和篡改。
  - **防火墙问题**：FTP 使用多个端口，容易受到防火墙限制。

### 1.2 SFTP

- **优势**：
  - **安全性高**：SFTP 基于 SSH 协议，提供加密的数据传输。
  - **单一端口**：SFTP 使用单一端口（默认 22），便于配置防火墙。

- **劣势**：
  - **依赖 SSH**：SFTP 需要 SSH 支持，配置相对复杂。
  - **性能较低**：由于加密开销，SFTP 的传输速度可能低于 FTP。

### 1.3 选择建议

在选择 FTP 和 SFTP 时，可以根据以下建议：

- 如果你需要安全的数据传输，并且服务器已经配置了 SSH，可以选择 **SFTP**。
- 如果你只需要简单的文件传输，并且不担心数据的安全性，可以选择 **FTP**。

## 2. 安装和配置 FTP 服务

在 **CentOS 9** 中，我们使用 **vsftpd**（Very Secure FTP Daemon）作为 FTP 服务器。

### 2.1 安装 vsftpd

首先，安装 **vsftpd**：

```sh
sudo dnf install -y vsftpd
```

### 2.2 启动和启用 vsftpd 服务

安装完成后，启动 **vsftpd** 服务并设置为开机自启：

```sh
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
```

### 2.3 配置 vsftpd

编辑 **vsftpd** 配置文件 `/etc/vsftpd/vsftpd.conf`，确保以下配置项已启用：

```sh
# 允许匿名用户访问
anonymous_enable=NO

# 允许本地用户访问
local_enable=YES

# 启用写操作
write_enable=YES

# 启用 chroot
chroot_local_user=YES

# 启用监听模式
listen=YES
```

### 2.4 配置防火墙

允许 **FTP** 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-service=ftp
sudo firewall-cmd --reload
```

### 2.5 创建 FTP 用户

创建一个本地用户用于 FTP 访问：

```sh
sudo useradd -m ftpuser
sudo passwd ftpuser
```

### 2.6 测试 FTP 访问

使用 FTP 客户端工具（如 FileZilla）连接服务器，测试 FTP 访问。使用刚才创建的 `ftpuser` 用户登录，验证 FTP 配置是否正确。

## 3. 安装和配置 SFTP 服务

在 **CentOS 9** 中，SFTP 服务基于 SSH 协议，因此我们使用 **OpenSSH** 来提供 SFTP 服务。

### 3.1 安装 OpenSSH

如果尚未安装 **OpenSSH**，可以使用以下命令进行安装：

```sh
sudo dnf install -y openssh-server
```

### 3.2 启动和启用 SSH 服务

启动 **SSH** 服务并设置为开机自启：

```sh
sudo systemctl start sshd
sudo systemctl enable sshd
```

### 3.3 配置 SFTP

编辑 **SSH** 配置文件 `/etc/ssh/sshd_config`，确保以下配置项已启用：

```sh
# 启用 SFTP 子系统
Subsystem sftp /usr/libexec/openssh/sftp-server

# 限制 SFTP 用户的权限（可选）
Match User sftpuser
    ChrootDirectory /home/sftpuser
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
```

### 3.4 配置防火墙

允许 **SSH** 服务通过防火墙：

```sh
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

### 3.5 创建 SFTP 用户

创建一个本地用户用于 SFTP 访问：

```sh
sudo useradd -m sftpuser
sudo passwd sftpuser

# 设置目录权限
sudo chown root:root /home/sftpuser
sudo chmod 755 /home/sftpuser
sudo mkdir /home/sftpuser/upload
sudo chown sftpuser:sftpuser /home/sftpuser/upload
```

### 3.6 测试 SFTP 访问

使用 SFTP 客户端工具（如 FileZilla）连接服务器，测试 SFTP 访问。使用刚才创建的 `sftpuser` 用户登录，验证 SFTP 配置是否正确。

## 4. 同时安装 FTP 和 SFTP 的端口冲突解决

在同时安装 **FTP** 和 **SFTP** 服务时，注意可能的端口冲突。默认情况下，FTP 使用端口 21，而 SFTP 使用端口 22。确保这两个端口没有冲突即可。

### 4.1 修改 FTP 端口

如果需要更改 FTP 服务的端口，可以在 **vsftpd** 配置文件 `/etc/vsftpd/vsftpd.conf` 中添加以下配置：

```sh
listen_port=2121
```

### 4.2 修改防火墙规则

修改防火墙规则，允许新的 FTP 端口通过：

```sh
sudo firewall-cmd --permanent --remove-service=ftp
sudo firewall-cmd --permanent --add-port=2121/tcp
sudo firewall-cmd --reload
```

## 5. 总结

在这篇文章中，我们详细介绍了 **FTP** 和 **SFTP** 的安装与配置。我们对比了这两种文件传输协议的特点和选择建议，随后分别介绍了 **vsftpd** 和 **OpenSSH** 的安装、配置及测试。此外，还讨论了同时安装 **FTP** 和 **SFTP** 时可能的端口冲突问题及其解决方法。在接下来的文章中，我们将深入探讨 **邮件服务器基础配置**，敬请期待。
