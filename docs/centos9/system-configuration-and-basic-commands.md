# CentOS 9 实战（2）：系统配置与基础命令

欢迎来到《CentOS 9 实战速查手册》专栏的第 2 篇文章。在这里，我们将继续深入学习 **CentOS 9**，了解系统配置和一些常用的基础命令。这些知识将帮助你更好地管理和操作 **CentOS** 系统，无论你是刚接触 **Linux** 的新手，还是已经有一些经验的系统管理员，这篇文章将为你提供实用的指导。

## 1. 系统配置

在完成 **CentOS 9** 的安装后，进行一些基础的系统配置是非常重要的。这包括网络配置、主机名设置、时间和日期配置等。

### 1.1 网络配置

使用 **`nmcli`** 工具来配置网络连接。**`nmcli`** 是 **NetworkManager** 的命令行接口，允许你从终端管理网络连接。

```sh
# 查看当前网络连接状态
nmcli device status

# 配置静态 IP 地址
nmcli con mod "System eth0" ipv4.addresses 192.168.1.100/24  # 设置静态 IP 地址
nmcli con mod "System eth0" ipv4.gateway 192.168.1.1  # 设置网关
nmcli con mod "System eth0" ipv4.dns "8.8.8.8 8.8.4.4"  # 设置 DNS 服务器
nmcli con mod "System eth0" ipv4.method manual  # 设置为手动 IP 配置模式
nmcli con up "System eth0"  # 启动网络连接
```

### 1.2 设置主机名

使用 **`hostnamectl`** 命令来设置主机名：

```sh
# 查看当前主机名
hostnamectl status

# 设置新的主机名
sudo hostnamectl set-hostname new-hostname
```

### 1.3 配置时间和日期

使用 **`timedatectl`** 命令来配置时间和日期：

```sh
# 查看当前时间和日期设置
timedatectl status

# 设置系统时区
sudo timedatectl set-timezone Asia/Shanghai

# 同步系统时间
sudo timedatectl set-ntp true
```

## 2. 基础命令

掌握一些基础命令对于管理和操作 **CentOS** 系统至关重要。下面是一些常用的基础命令：

### 2.1 文件和目录操作

```sh
# 列出目录内容
ls -la

# 创建目录
mkdir /path/to/directory

# 删除文件或目录
rm -rf /path/to/file_or_directory

# 复制文件或目录
cp -r /path/to/source /path/to/destination

# 移动或重命名文件或目录
mv /path/to/source /path/to/destination
```

### 2.2 文件权限管理

```sh
# 修改文件权限
chmod 755 /path/to/file

# 修改文件所有者
sudo chown user:group /path/to/file

# 查看文件权限
ls -l /path/to/file
```

### 2.3 系统信息查看

```sh
# 查看系统内存使用情况
free -h

# 查看磁盘使用情况
df -h

# 查看 CPU 信息
lscpu

# 查看运行中的进程
ps aux

# 显示系统的当前运行时间和负载
uptime
```

### 2.4 软件包管理

```sh
# 安装软件包
sudo dnf install package_name

# 更新所有软件包
sudo dnf update -y

# 删除软件包
sudo dnf remove package_name

# 搜索软件包
dnf search package_name
```

### 2.5 关机与重启

```sh
# 关机命令
sudo shutdown -h now  # 立即关机
sudo shutdown -h +10  # 10 分钟后关机
sudo shutdown -h 20:30  # 在指定时间关机

# 重启命令
sudo shutdown -r now  # 立即重启
sudo shutdown -r +10  # 10 分钟后重启
sudo reboot  # 立即重启
sudo init 6  # 立即重启，等同于 reboot
```

### 2.6 压缩与解压缩

```sh
# 压缩文件为 tar.gz 格式
tar -czvf archive.tar.gz /path/to/directory_or_file

# 解压 tar.gz 文件
tar -xzvf archive.tar.gz

# 压缩文件为 zip 格式
zip -r archive.zip /path/to/directory_or_file

# 解压 zip 文件
unzip archive.zip
```

## 3. 实用工具

以下是一些在日常管理 **CentOS** 系统中非常有用的工具：

### 3.1 vim 编辑器

**`vim`** 是一个强大的文本编辑器，适用于编辑配置文件和脚本：

```sh
# 安装 vim
sudo dnf install -y vim

# 使用 vim 编辑文件
vim /path/to/file
```

### 3.2 wget 和 curl

这两个工具用于从命令行下载文件和进行 **HTTP 请求**：

```sh
# 安装 wget 和 curl
sudo dnf install -y wget curl

# 使用 wget 下载文件
wget http://example.com/file

# 使用 curl 下载文件
curl -O http://example.com/file
```

### 3.3 git

**`git`** 是一个流行的版本控制系统，用于管理代码和项目：

```sh
# 安装 git
sudo dnf install -y git

# 克隆一个 git 仓库
git clone https://github.com/user/repository.git
```

### 3.4 net-tools

**`net-tools`** 包含一组基本的网络命令，用于网络配置和故障排除。常用的命令包括 **`ifconfig`**、**`netstat`**、**`route`** 和 **`arp`**。

```sh
# 安装 net-tools
sudo dnf install -y net-tools

# 查看网络接口配置
ifconfig

# 显示网络连接和端口信息
netstat -tuln

# 查看和修改路由表
route -n

# 查看和管理 ARP 缓存
arp -a
```

## 4. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的基本系统配置和一些常用的基础命令。通过掌握这些知识，你可以更高效地管理和操作你的 **CentOS** 系统。在接下来的文章中，我们将深入探讨 **用户和权限管理**，敬请期待。
