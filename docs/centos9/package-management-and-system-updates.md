# CentOS 9 实战（5）：软件包管理与系统更新

欢迎来到《CentOS 9 实战速查手册》专栏的第 5 篇文章。在这里，我们将探讨 **CentOS 9** 中的**软件包管理和系统更新**。掌握这些知识可以帮助你有效地安装、更新和删除软件包，确保系统始终保持最新状态和最佳性能。

## 1. 软件包管理工具

**CentOS 9** 使用 **`dnf`** 作为默认的软件包管理工具，取代了之前的 **`yum`**。**`dnf`** 提供了更快的依赖解析、更好的性能和更丰富的插件支持。

### 1.1 dnf 的基本命令

#### 安装软件包

使用 **`dnf install`** 命令安装软件包：

```sh
# 安装单个软件包
sudo dnf install package_name

# 安装多个软件包
sudo dnf install package_name1 package_name2
```

#### 更新软件包

使用 **`dnf update`** 命令更新系统中的所有软件包：

```sh
# 更新所有软件包
sudo dnf update -y
```

#### 删除软件包

使用 **`dnf remove`** 命令删除软件包：

```sh
# 删除单个软件包
sudo dnf remove package_name

# 删除多个软件包
sudo dnf remove package_name1 package_name2
```

#### 搜索软件包

使用 **`dnf search`** 命令搜索软件包：

```sh
# 搜索包含关键字的软件包
dnf search keyword
```

#### 列出已安装的软件包

使用 **`dnf list installed`** 命令列出系统中已安装的软件包：

```sh
# 列出所有已安装的软件包
dnf list installed
```

### 1.2 dnf 和 yum 的区别

**`dnf`** 和 **`yum`** 之间的主要区别包括：

- **依赖解析**：**`dnf`** 使用 **`libsolv`** 库进行依赖解析，速度更快，准确性更高。
- **性能**：**`dnf`** 在处理大量软件包和元数据时，性能明显优于 **`yum`**。
- **插件支持**：**`dnf`** 提供了更丰富和灵活的插件支持，便于扩展和定制功能。
- **命令兼容**：大部分 **`yum`** 的命令和选项在 **`dnf`** 中仍然适用，便于用户迁移和使用。

## 2. EPEL 仓库

**EPEL** (Extra Packages for Enterprise Linux) 是由 **Fedora** 项目维护的一个软件包仓库，提供了大量的额外软件包，可以扩展 **CentOS** 系统的功能。

### 2.1 启用 EPEL 仓库

使用以下命令启用 **EPEL 仓库**：

```sh
# 安装 EPEL 仓库
sudo dnf install -y epel-release

# 更新仓库元数据
sudo dnf update -y
```

### 2.2 安装 EPEL 软件包

启用 **EPEL 仓库** 后，你可以使用 **`dnf`** 命令安装 **EPEL** 中的软件包：

```sh
# 安装 EPEL 软件包
sudo dnf install package_name
```

## 3. 系统更新与升级

保持系统和软件包的最新状态是确保系统安全性和性能的重要措施。

### 3.1 更新系统

使用 **`dnf update`** 命令更新系统中的所有软件包：

```sh
# 更新所有软件包
sudo dnf update -y
```

### 3.2 自动更新配置

可以配置系统自动执行软件包更新，确保系统始终保持最新状态。

#### 安装 dnf-automatic

**`dnf-automatic`** 是一个可以自动更新系统的软件包：

```sh
# 安装 dnf-automatic
sudo dnf install -y dnf-automatic
```

#### 配置 dnf-automatic

编辑 **`/etc/dnf/automatic.conf`** 文件，配置自动更新选项：

```sh
sudo vim /etc/dnf/automatic.conf
```

确保以下配置项设置为 `true`：

```ini
[commands]
upgrade_type = default
random_sleep = 0
download_updates = yes
apply_updates = yes
```

#### 启用自动更新服务

使用以下命令启用并启动 **`dnf-automatic`** 服务：

```sh
# 启用 dnf-automatic 服务
sudo systemctl enable --now dnf-automatic.timer
```

## 4. 软件包管理的高级功能

### 4.1 使用 `dnf history` 命令

**`dnf history`** 命令可以查看和管理软件包操作历史记录：

```sh
# 查看历史记录
dnf history

# 撤销最近一次操作
sudo dnf history undo last

# 重做最近一次操作
sudo dnf history redo last
```

### 4.2 清理缓存

使用 **`dnf clean`** 命令清理缓存文件，释放磁盘空间：

```sh
# 清理缓存
sudo dnf clean all
```

## 5. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的**软件包管理和系统更新**，包括 **`dnf`** 的基本命令、**`EPEL` 仓库的启用和使用**，以及**自动更新配置**。通过掌握这些知识，你可以更高效地管理和维护你的 **CentOS** 系统。在接下来的文章中，我们将深入探讨 **服务管理与 systemd**，敬请期待。
