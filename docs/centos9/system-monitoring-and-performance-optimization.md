# CentOS 9 实战（9）：系统监控与性能优化

欢迎来到《CentOS 9 实战速查手册》专栏的第 9 篇文章。在这里，我们将深入探讨 **CentOS 9** 中的**系统监控与性能优化**。系统监控是了解系统健康状况和诊断问题的关键步骤，而性能优化则是确保系统在高效状态下运行的必要措施。通过掌握这些技能，你可以更好地维护和优化 **CentOS** 系统。

## 1. 系统监控工具

在 **CentOS 9** 中，有许多工具可以帮助你监控系统的性能和健康状况。

### 1.1 top 命令

**`top`** 命令用于实时显示系统的性能统计信息，包括 **CPU**、内存使用情况和运行的进程。

#### 查看系统性能

你想查看系统的实时性能统计信息：

```sh
# 查看系统性能
top
```

**常用键说明**：

- **M**：按内存使用量排序。
- **P**：按 CPU 使用量排序。
- **T**：按运行时间排序。
- **q**：退出 top。

### 1.2 htop 命令

**`htop`** 是一个更友好的系统监控工具，提供了更直观的界面和更多的功能。你需要先安装 **`htop`**：

```sh
# 安装 htop
sudo dnf install -y htop
```

#### 使用 htop 查看系统性能

你想使用 **`htop`** 查看系统性能：

```sh
# 查看系统性能
htop
```

**常用键说明**：

- **F2**：进入设置菜单。
- **F3**：搜索进程。
- **F9**：杀死进程。
- **q**：退出 htop。

### 1.3 vmstat 命令

**`vmstat`** 命令用于报告虚拟内存、进程、**CPU** 活动等信息。

#### 查看系统统计信息

你想查看系统的统计信息，每隔 2 秒刷新一次，显示 5 次：

```sh
# 查看系统统计信息
vmstat 2 5
```

### 1.4 iostat 命令

**`iostat`** 命令用于监控系统输入/输出设备的活动。

#### 安装 sysstat 工具包

**`iostat`** 是 **sysstat** 工具包的一部分。你需要先安装 **sysstat**：

```sh
# 安装 sysstat
sudo dnf install -y sysstat
```

#### 查看 I/O 统计信息

你想查看系统的 I/O 统计信息：

```sh
# 查看 I/O 统计信息
iostat
```

### 1.5 free 命令

**`free`** 命令用于显示系统的内存使用情况。

#### 查看内存使用情况

你想查看系统的内存使用情况：

```sh
# 查看内存使用情况
free -h
```

### 1.6 sar 命令

**`sar`** 命令用于收集、报告和保存系统活动信息，是 **sysstat** 工具包的一部分。

#### 启用 sysstat 服务

你需要启用并启动 **sysstat** 服务，以便 **`sar`** 能够收集数据：

```sh
# 启用并启动 sysstat 服务
sudo systemctl enable --now sysstat
```

#### 查看系统活动信息

你想查看系统的 **CPU** 使用情况：

```sh
# 查看 CPU 使用情况
sar -u 1 5
```

## 2. 性能优化技巧

通过了解系统的性能瓶颈，可以采取措施优化系统性能。以下是一些常见的性能优化技巧：

### 2.1 优化 CPU 使用

#### 识别高 CPU 使用进程

使用 **`top`** 或 **`htop`** 识别占用高 **CPU** 的进程，然后使用 **`kill`** 命令终止或调整这些进程。

```sh
# 终止进程
sudo kill -9 <PID>
```

### 2.2 优化内存使用

#### 清理缓存和释放内存

你可以使用以下命令清理缓存并释放内存：

```sh
# 清理缓存
sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
```

### 2.3 优化磁盘 I/O

#### 使用 iotop 监控磁盘 I/O

**`iotop`** 命令用于监控磁盘 I/O。你需要先安装 **`iotop`**：

```sh
# 安装 iotop
sudo dnf install -y iotop
```

#### 查看磁盘 I/O

你想使用 **`iotop`** 查看系统的磁盘 I/O 活动：

```sh
# 查看磁盘 I/O
sudo iotop
```

### 2.4 优化网络性能

#### 调整网络参数

你可以调整一些网络参数来优化网络性能。例如，增加 **TCP** 缓冲区大小：

```sh
# 增加 TCP 缓冲区大小
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.wmem_max=16777216
```

## 3. 系统日志分析

系统日志是诊断和解决问题的重要工具。通过分析系统日志，你可以了解系统运行状况并发现潜在问题。

### 3.1 使用 journalctl 查看日志

**`journalctl`** 命令用于查看由 **`systemd`** 管理的系统日志。

#### 查看所有日志

```sh
# 查看所有日志
sudo journalctl
```

#### 查看特定服务的日志

你想查看 **httpd** 服务的日志：

```sh
# 查看特定服务的日志
sudo journalctl -u httpd
```

#### 实时查看日志

```sh
# 实时查看日志输出
sudo journalctl -f
```

### 3.2 使用 logrotate 管理日志文件

**`logrotate`** 工具用于自动轮换、压缩和删除日志文件。

#### 查看 logrotate 配置

你可以查看 **`logrotate`** 的全局配置文件：

```sh
# 查看 logrotate 配置
cat /etc/logrotate.conf
```

#### 配置日志轮换

你可以为特定服务配置日志轮换。例如，为 **httpd** 配置日志轮换：

```sh
# 创建 httpd 日志轮换配置
sudo vim /etc/logrotate.d/httpd

# 添加以下内容
/var/log/httpd/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 640 root adm
    sharedscripts
    postrotate
        /bin/systemctl reload httpd > /dev/null 2>/dev/null || true
    endscript
}
```

## 4. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的**系统监控与性能优化**，包括使用 **`top`**、**`htop`**、**`vmstat`**、**`iostat`**、**`free`**、**`sar`** 等工具进行系统监控，以及一些常见的性能优化技巧和系统日志分析方法。通过掌握这些知识，你可以更高效地监控和优化 **CentOS** 系统的性能。在接下来的文章中，我们将深入探讨 **SSH 服务配置与使用**，敬请期待。
