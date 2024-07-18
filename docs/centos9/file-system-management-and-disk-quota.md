# CentOS 9 实战（6）：文件系统管理与磁盘配额

欢迎来到《CentOS 9 实战速查手册》专栏的第 6 篇文章。在这里，我们将深入探讨 **CentOS 9** 中的**文件系统管理与磁盘配额**。文件系统是操作系统用于组织和管理数据的重要组成部分，而磁盘配额则是控制用户和组使用磁盘空间的一种机制。掌握这些知识可以帮助你更高效地管理和维护 **CentOS** 系统的存储资源。

## 1. 文件系统管理

### 1.1 文件系统的基本操作

在 **CentOS 9** 中，文件系统的管理包括**创建、挂载和卸载文件系统**等操作。

#### 创建文件系统

假设你有一个新的磁盘分区 **/dev/sdb1**，你想将其格式化为 **ext4** 文件系统：

```sh
# 创建 ext4 文件系统
sudo mkfs.ext4 /dev/sdb1

# 创建 xfs 文件系统
sudo mkfs.xfs /dev/sdb1
```

#### 挂载文件系统

你想将 **/dev/sdb1** 挂载到 **/mnt/data** 目录：

```sh
# 创建挂载点目录
sudo mkdir -p /mnt/data

# 挂载文件系统
sudo mount /dev/sdb1 /mnt/data
```

#### 卸载文件系统

你需要临时卸载 **/mnt/data** 以进行维护：

```sh
# 卸载文件系统
sudo umount /mnt/data
```

### 1.2 持久化挂载

要在系统重启后自动挂载文件系统，需要将其添加到 **/etc/fstab** 文件中。

#### 编辑 /etc/fstab 文件

假设你希望 **/dev/sdb1** 在系统启动时自动挂载到 **/mnt/data**：

```sh
# 编辑 /etc/fstab 文件
sudo vim /etc/fstab

# 添加以下行
/dev/sdb1 /mnt/data ext4 defaults 0 0
```

保存并退出编辑器。

### 1.3 检查和修复文件系统

当你怀疑 **/dev/sdb1** 有文件系统错误时，可以使用 **`fsck`** 命令检查和修复：

```sh
# 检查并修复文件系统
sudo fsck /dev/sdb1
```

### 1.4 查看磁盘使用情况

你想查看系统中的磁盘使用情况：

```sh
# 查看磁盘空间使用情况
df -h

# 查看目录和文件的磁盘使用情况
du -sh /mnt/data
```

## 2. 磁盘配额管理

磁盘配额用于限制用户和组的磁盘空间使用量，从而防止某个用户或组占用过多的磁盘空间。

### 2.1 安装 quota 工具

在最小化安装的 **CentOS 9** 中，`quota` 相关命令默认不存在。你需要先安装这些工具：

```sh
# 安装 quota 工具
sudo dnf install quota
```

### 2.2 启用磁盘配额

要启用磁盘配额，需要修改 **/etc/fstab** 文件，并使用 **`quota`** 命令进行配置。

#### 修改 /etc/fstab 文件

假设你希望在 **/mnt/data** 上启用用户和组配额：

```sh
# 编辑 /etc/fstab 文件
sudo vim /etc/fstab

# 添加以下行
/dev/sdb1 /mnt/data ext4 defaults,usrquota,grpquota 0 0
```

保存并退出编辑器。

#### 重新挂载文件系统

重新挂载 **/mnt/data** 以使更改生效：

```sh
# 重新挂载文件系统
sudo mount -o remount /mnt/data
```

### 2.3 初始化配额文件

你需要初始化配额文件以开始使用磁盘配额：

```sh
# 初始化配额文件
sudo quotacheck -cug /mnt/data
```

### 2.4 启用配额

启用配额以便实际应用：

```sh
# 启用配额
sudo quotaon /mnt/data
```

### 2.5 配置用户和组配额

你想为用户 **alice** 配置磁盘配额：

```sh
# 配置用户配额
sudo edquota alice
```

在编辑器中，你可以设置 **软配额（soft limit）** 和 **硬配额（hard limit）**：

```sh
Disk quotas for user alice (uid 1001):
  Filesystem                   blocks       soft       hard     inodes     soft     hard
  /dev/sdb1                    50000       60000      70000          0        0        0
```

### 2.6 查看配额使用情况

你想查看用户 **alice** 的配额使用情况：

```sh
# 查看用户配额使用情况
quota alice

# 查看文件系统的配额使用报告
sudo repquota /mnt/data
```

## 3. 实用工具

以下是一些在文件系统管理和磁盘配额中非常有用的工具和命令：

### 3.1 tune2fs

假设你希望查看 **/dev/sdb1** 文件系统的信息并设置文件系统标签：

```sh
# 查看文件系统信息
sudo tune2fs -l /dev/sdb1

# 设置文件系统标签
sudo tune2fs -L mylabel /dev/sdb1
```

### 3.2 xfs_admin

假设你使用的是 **XFS** 文件系统，并希望查看文件系统信息和设置标签：

```sh
# 查看文件系统信息
sudo xfs_info /mnt/data

# 设置文件系统标签
sudo xfs_admin -L mylabel /dev/sdb1
```

## 4. 总结

在这篇文章中，我们介绍了 **CentOS 9** 的**文件系统管理与磁盘配额**，包括**文件系统的创建、挂载和卸载**，以及**磁盘配额的启用和配置**。我们还讨论了一些常用的工具和命令，并提供了实际应用场景。通过掌握这些知识，你可以更高效地管理和维护 **CentOS** 系统的存储资源。在接下来的文章中，我们将深入探讨 **网络配置与管理**，敬请期待。
