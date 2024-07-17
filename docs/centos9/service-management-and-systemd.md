# CentOS 9 实战（5）：服务管理与 systemd

## 1. 引言

欢迎来到《CentOS 9 实战之九阳神功》专栏的第 5 篇文章。在这里，我们将深入探讨 CentOS 9 中的**服务管理与 `systemd`**。**`systemd` 是一种系统和服务管理器**，用于在系统启动时启动服务、管理后台进程以及系统状态。掌握 `systemd` 可以帮助你更高效地管理和维护 CentOS 系统的服务。

## 2. systemd 简介

**`systemd`** 是 Linux 的系统和服务管理器，设计用来取代传统的 **`SysVinit`** 和 **`Upstart`** 系统初始化程序。**`systemd`** 提供了**并行启动服务**、**依赖关系管理**和**更详细的日志**功能。

### 2.1 systemd 的优点

- **并行启动**：加速系统启动时间。
- **依赖关系**：管理服务之间的依赖关系，确保服务按正确顺序启动。
- **日志记录**：通过 **`journald`** 提供详细的日志记录和查询功能。
- **统一管理**：统一的接口和工具来管理系统和服务。

### 2.2 应用场景

- **服务器管理**：管理和监控服务器上的各种服务，如 **Apache**、**Nginx**、**MySQL** 等。
- **系统初始化**：加快系统启动时间，并管理启动顺序。
- **日志管理**：通过 **`journalctl`** 提供详细的系统日志和服务日志。

## 3. 服务管理

使用 **`systemd`** 管理服务主要通过以下几个常用命令实现：

### 3.1 启动和停止服务

```sh
# 启动服务
sudo systemctl start httpd

# 停止服务
sudo systemctl stop httpd
```

### 3.2 重启和重新加载服务

```sh
# 重启服务
sudo systemctl restart httpd

# 重新加载服务配置
sudo systemctl reload httpd
```

### 3.3 启用和禁用服务

```sh
# 启用服务，使其在系统启动时自动启动
sudo systemctl enable httpd

# 禁用服务，使其在系统启动时不自动启动
sudo systemctl disable httpd
```

### 3.4 查看服务状态

```sh
# 查看服务的当前状态
sudo systemctl status httpd
```

### 3.5 查看所有服务

```sh
# 列出所有服务及其状态
sudo systemctl list-units --type=service
```

## 4. systemd 单元文件

**`systemd`** 通过单元文件（**Unit File**）来管理服务。**单元文件描述了服务的启动、停止和依赖关系**等信息。单元文件通常存放在 **`/etc/systemd/system/`** 和 **`/usr/lib/systemd/system/`** 目录下。

### 4.1 单元文件结构

一个典型的单元文件包含以下几个部分：

```ini
[Unit]
Description=Service Description
After=network.target

[Service]
ExecStart=/usr/bin/executable
ExecStop=/usr/bin/stop-command
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

- **[Unit]** 部分定义服务的描述和依赖关系。
- **[Service]** 部分定义服务的启动、重新加载和停止命令。
- **[Install]** 部分定义服务的安装行为。

### 4.2 具体服务示例

以 **Apache HTTP Server** 为例，单元文件定义了 **Apache** 服务的**启动**、**停止**和**重启**命令，以及相关的依赖关系。下面是一个简化的 **Apache** 单元文件：

```ini
[Unit]
Description=Apache HTTP Server
After=network.target

[Service]
ExecStart=/usr/sbin/httpd -DFOREGROUND
ExecReload=/usr/sbin/httpd -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}
Type=forking
PIDFile=/var/run/httpd/httpd.pid

[Install]
WantedBy=multi-user.target
```

在这个文件中，**`ExecStart`** 指定了启动 **Apache** 的命令，**`ExecReload`** 指定了重新加载 **Apache** 配置的命令，**`ExecStop`** 指定了停止 **Apache** 的命令。

## 5. 创建自定义服务

创建一个自定义服务的步骤如下：

### 5.1 实战案例：配置自定义服务

假设我们有一个 Python 脚本 **`my_script.py`**，需要将其配置为系统服务。

- 创建一个新的单元文件：

```sh
sudo vim /etc/systemd/system/myscript.service
```

- 在文件中添加以下内容：

```ini
[Unit]
Description=My Custom Python Script
After=network.target

[Service]
ExecStart=/usr/bin/python3 /path/to/my_script.py
Restart=on-failure
User=myuser
Group=mygroup

[Install]
WantedBy=multi-user.target
```

- 重新加载 **`systemd`** 配置：

```sh
sudo systemctl daemon-reload
```

- 启动并启用服务：

```sh
sudo systemctl start myscript.service
sudo systemctl enable myscript.service
```

- 查看服务状态：

```sh
sudo systemctl status myscript.service
```

通过这些步骤，我们将一个 Python 脚本配置为系统服务，确保其在系统启动时自动运行，并在失败时自动重启。

## 6. journalctl 日志管理

**`journalctl`** 是 **`systemd`** 的日志管理工具，用于查询和显示系统日志。

### 6.1 查看日志

```sh
# 查看所有日志
sudo journalctl

# 查看指定服务的日志
sudo journalctl -u myscript.service
```

### 6.2 实时查看日志

```sh
# 实时查看日志输出
sudo journalctl -f
```

### 6.3 查看系统启动日志

```sh
# 查看最近一次启动的日志
sudo journalctl -b

# 查看前一次启动的日志
sudo journalctl -b -1
```

### 6.4 过滤日志

```sh
# 根据时间过滤日志
sudo journalctl --since "2023-07-01" --until "2023-07-02"

# 根据优先级过滤日志（0-7，数字越小优先级越高）
sudo journalctl -p 3
```

## 7. 总结

在这篇文章中，我们介绍了 CentOS 9 的**服务管理与 `systemd`**，包括**服务的启动、停止、重启和查看状态**，以及**如何创建和管理自定义服务**。我们还讨论了 **`journalctl` 日志管理工具及其常用命令**。通过掌握这些知识，你可以更高效地管理和维护 CentOS 系统的服务。在接下来的文章中，我们将深入探讨 **文件系统管理与磁盘配额**，敬请期待。
