# CentOS 9 实战（7）：网络配置与管理

欢迎来到《CentOS 9 实战速查手册》专栏的第 7 篇文章。在这里，我们将深入探讨 **CentOS 9** 中的**网络配置与管理**。网络配置是系统管理员必须掌握的基本技能之一，通过学习网络配置，你将能够设置和管理网络连接，确保系统的网络通信正常运行。

## 1. 网络配置工具

在 **CentOS 9** 中，主要使用 **`nmcli`** 和 **`nmtui`** 工具来管理网络连接。

### 1.1 nmcli

**`nmcli`** 是 NetworkManager 的命令行接口，用于从终端管理网络连接。

#### 查看网络连接

你想查看当前的网络连接状态：

```sh
# 查看网络设备状态
nmcli device status
```

#### 查看指定网络接口的当前配置

你想查看网络接口 **ens33** 的当前配置：

```sh
# 查看指定网络接口的当前配置
nmcli device show ens33
```

要查看更详细的信息，包括是否使用 **DHCP** 以及 **DNS** 设置，可以使用以下命令：

```sh
# 查看详细的连接信息
nmcli connection show ens33
```

#### 配置静态 IP 地址

你希望为网络接口 **ens33** 配置静态 IP 地址：

```sh
# 列出当前的连接
nmcli connection show

# 修改现有连接的名称（假设名称是 ens33）
nmcli connection modify ens33 ipv4.addresses 192.168.1.100/24  # 设置静态 IP 地址
nmcli connection modify ens33 ipv4.gateway 192.168.1.1  # 设置网关
nmcli connection modify ens33 ipv4.dns "8.8.8.8 8.8.4.4"  # 设置 DNS 服务器
nmcli connection modify ens33 ipv4.method manual  # 设置为手动 IP 配置模式
nmcli connection up ens33  # 启动网络连接
```

#### 配置 DHCP

你希望将网络接口 **ens33** 配置为通过 **DHCP** 获取 IP 地址：

```sh
# 配置 DHCP
nmcli connection modify ens33 ipv4.method auto
nmcli connection up ens33
```

### 1.2 nmtui

**`nmtui`** 是 NetworkManager 的图形化终端用户界面，适用于在终端环境下进行网络配置。

#### 启动 nmtui

```sh
# 启动 nmtui
sudo nmtui
```

在 **nmtui** 界面中，你可以轻松地配置网络连接、设置主机名以及激活或禁用网络连接。

## 2. 网络工具

在 **CentOS 9** 中，有许多网络工具可以帮助你管理和诊断网络连接。

### 2.1 ip 命令

**`ip`** 命令是一个强大的网络配置工具，用于管理网络接口、路由和策略路由。

#### 查看网络接口信息

你想查看所有网络接口的信息：

```sh
# 查看所有网络接口的信息
ip addr show
```

#### 添加 IP 地址

你希望为网络接口 **ens33** 添加一个新的 IP 地址：

```sh
# 添加新的 IP 地址
sudo ip addr add 192.168.1.101/24 dev ens33
```

#### 删除 IP 地址

你需要删除网络接口 **ens33** 上的 IP 地址：

```sh
# 删除 IP 地址
sudo ip addr del 192.168.1.101/24 dev ens33
```

#### 查看路由表

你想查看当前的路由表信息：

```sh
# 查看路由表信息
ip route show
```

#### 添加默认路由

你希望添加一个默认路由：

```sh
# 添加默认路由
sudo ip route add default via 192.168.1.1
```

### 2.2 ping 命令

**`ping`** 命令用于测试网络连通性。

#### 测试网络连通性

你想测试与 **google.com** 的连通性：

```sh
# 测试网络连通性
ping google.com
```

### 2.3 netstat 命令

**`netstat`** 命令用于显示网络连接、路由表、接口统计信息等。

#### 查看网络连接信息

你希望查看当前的网络连接信息：

```sh
# 查看网络连接信息
netstat -tuln
```

**参数解释**：

- **-t**：显示 **TCP** 连接。
- **-u**：显示 **UDP** 连接。
- **-l**：显示监听状态的套接字。
- **-n**：以数字形式显示地址和端口。

#### 查看接口统计信息

你想查看网络接口的统计信息：

```sh
# 查看接口统计信息
netstat -i
```

#### 查看路由表信息

你想查看路由表信息：

```sh
# 查看路由表信息
netstat -r
```

### 2.4 traceroute 命令

**`traceroute`** 命令用于跟踪数据包到目标主机的路由路径。**CentOS 9** 最小化安装没有提供此命令，你需要先安装：

```sh
# 安装 traceroute
sudo dnf install -y traceroute
```

#### 跟踪路由路径

你想跟踪到 **google.com** 的路由路径：

```sh
# 跟踪路由路径
traceroute google.com
```

**参数解释**：

- **-m**：设置最大跳数（最大 TTL 值）。
- **-w**：设置等待每个响应的超时时间。

#### 设置最大跳数

你希望将最大跳数设置为 10：

```sh
# 设置最大跳数为 10
traceroute -m 10 google.com
```

#### 设置等待时间

你希望设置等待每个响应的超时时间为 5 秒：

```sh
# 设置等待时间为 5 秒
traceroute -w 5 google.com
```

### 2.5 curl 和 wget

**`curl`** 和 **`wget`** 命令用于从命令行下载文件和进行 **HTTP** 请求。

#### 使用 curl 下载文件

你希望使用 **`curl`** 下载一个文件：

```sh
# 使用 curl 下载文件
curl -O http://example.com/file
```

#### 使用 wget 下载文件

你希望使用 **`wget`** 下载一个文件：

```sh
# 使用 wget 下载文件
wget http://example.com/file
```

### 2.6 lsof 命令

**`lsof`** 命令用于列出打开的文件，包括正在使用的网络端口。**lsof** 需要单独安装：

```sh
# 安装 lsof
sudo dnf install -y lsof

# 查看当前被占用的端口
sudo lsof -i -P -n

# 检查端口是否被占用
sudo lsof -i:8080
```

## 3. 防火墙配置

在 **CentOS 9** 中，默认的防火墙管理工具是 **firewalld**。

### 3.1 启动和停止 firewalld

```sh
# 启动 firewalld
sudo systemctl start firewalld

# 停止 firewalld
sudo systemctl stop firewalld
```

### 3.2 查看防火墙状态

```sh
# 查看防火墙状态
sudo firewall-cmd --state
```

### 3.3 配置防火墙规则

#### 添加服务

你希望允许 **HTTP** 服务通过防火墙：

```sh
# 添加 HTTP 服务
sudo firewall-cmd --permanent --add-service=http
# 重新加载防火墙规则
sudo firewall-cmd --reload
```

#### 添加端口

你希望允许 **TCP** 端口 8080 通过防火墙：

```sh
# 添加 TCP 端口 8080
sudo firewall-cmd --permanent --add-port=8080/tcp
# 重新加载防火墙规则
sudo firewall-cmd --reload
```

### 3.4 删除防火墙规则

#### 删除服务

你希望删除 **HTTP** 服务的防火墙规则：

```sh
# 删除 HTTP 服务
sudo firewall-cmd --permanent --remove-service=http
# 重新加载防火墙规则
sudo firewall-cmd --reload
```

#### 删除端口

你希望删除 **TCP** 端口 8080 的防火墙规则：

```sh
# 删除 TCP 端口 8080
sudo firewall-cmd --permanent --remove-port=8080/tcp
# 重新加载防火墙规则
sudo firewall-cmd --reload
```

### 3.5 查看当前防火墙配置

你希望查看当前配置了哪些规则和服务：

```sh
# 查看当前配置了哪些规则和服务
sudo firewall-cmd --list-all
```

## 4. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的**网络配置与管理**，包括使用 **`nmcli`** 和 **`nmtui`** 进行网络配置，常用网络工具如 **`ip`**、**`ping`**、**`netstat`**、**`traceroute`**、**`curl`** 和 **`wget`** 的使用，以及 **firewalld** 的基本配置。通过掌握这些知识，你可以更高效地管理和维护 **CentOS** 系统的网络配置。在接下来的文章中，我们将深入探讨 **系统监控与性能优化**，敬请期待。
