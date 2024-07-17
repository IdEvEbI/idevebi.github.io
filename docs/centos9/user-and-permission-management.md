# CentOS 9 实战（3）：用户和权限管理

## 1. 引言

欢迎来到《CentOS 9 实战之九阳神功》专栏的第 3 篇文章。在这里，我们将探讨 CentOS 9 中的**用户和权限管理**。用户和权限管理是系统安全和资源控制的重要组成部分。通过学习本篇文章，你将了解如何创建和管理用户、组，以及如何设置文件和目录的权限，确保系统的安全和高效运行。

## 2. 用户管理

在 CentOS 9 中，用户管理主要包括创建用户、删除用户和修改用户信息。我们将通过一些常用命令来实现这些操作。

### 2.1 创建用户

使用 `useradd` 命令来创建新用户：

```sh
# 创建一个新用户
sudo useradd newuser

# 为新用户设置密码
sudo passwd newuser
```

### 2.2 修改用户信息

使用 `usermod` 命令来修改用户信息：

```sh
# 修改用户名
sudo usermod -l newusername oldusername

# 修改用户主目录
sudo usermod -d /new/home/directory newusername

# 将用户添加到新组
sudo usermod -aG groupname username
```

### 2.3 删除用户

使用 `userdel` 命令来删除用户：

```sh
# 删除用户但保留主目录
sudo userdel username

# 删除用户及其主目录
sudo userdel -r username
```

### 2.4 /etc/passwd 文件

`/etc/passwd` 文件包含了系统中所有用户的信息。每行表示一个用户，字段之间用冒号分隔：

```sh
cat /etc/passwd
```

示例输出：

```sh
root:x:0:0:root:/root:/bin/bash
user1:x:1001:1001::/home/user1:/bin/bash
```

字段解释：

- `root`：用户名
- `x`：密码占位符（实际密码存储在 /etc/shadow 文件中）
- `0`：用户 ID (UID)
- `0`：组 ID (GID)
- `root`：用户描述信息
- `/root`：用户主目录
- `/bin/bash`：用户的默认 `shell`

## 3. 组管理

组管理是用户管理的重要部分，通过将用户分配到不同的组，可以更好地控制用户的权限和访问资源的范围。

### 3.1 创建组

使用 `groupadd` 命令来创建新组：

```sh
# 创建一个新组
sudo groupadd newgroup
```

### 3.2 修改组信息

使用 `groupmod` 命令来修改组信息：

```sh
# 修改组名
sudo groupmod -n newgroupname oldgroupname
```

### 3.3 删除组

使用 `groupdel` 命令来删除组：

```sh
# 删除组
sudo groupdel groupname
```

### 3.4 /etc/group 文件

`/etc/group` 文件包含了系统中所有组的信息。每行表示一个组，字段之间用冒号分隔：

```sh
cat /etc/group
```

示例输出：

```sh
root:x:0:
newgroup:x:1001:
```

字段解释：

- `root`：组名
- `x`：密码占位符（通常为空）
- `0`：组 ID (GID)
- ``：组成员列表（以逗号分隔）

## 4. 文件和目录权限管理

在 CentOS 中，文件和目录的权限控制通过三种权限类型和三类用户来实现：读 (r)、写 (w)、执行 (x) 权限，以及所有者、组和其他用户。

### 4.1 查看权限

使用 `ls -l` 命令来查看文件和目录的权限：

```sh
# 查看文件和目录权限
ls -l /path/to/file_or_directory
```

输出示例：

```sh
-rw-r--r-- 1 owner group 4096 Jun  1 12:34 filename
```

权限说明：

- `-rw-r--r--`：文件类型和权限
- `1`：硬链接数
- `owner`：文件所有者
- `group`：文件所属组
- `4096`：文件大小（字节）
- `Jun  1 12:34`：最后修改时间
- `filename`：文件名

### 4.2 创建硬链接和软链接

硬链接和软链接（符号链接）是 Unix 文件系统的基本特性，用于创建文件的引用。

#### 4.2.1 硬链接

硬链接是文件系统中多个目录项指向同一个 inode 的情况。删除任何一个硬链接，文件内容不会被删除，只有当所有硬链接都删除后，文件内容才会被删除。

```sh
# 创建硬链接
ln /path/to/original /path/to/hardlink
```

#### 4.2.2 软链接

软链接是一个指向另一个文件或目录的符号路径。删除软链接不会影响目标文件，但删除目标文件会导致软链接变为无效。

```sh
# 创建软链接
ln -s /path/to/original /path/to/symlink
```

### 4.3 修改权限

使用 `chmod` 命令来修改文件和目录的权限：

```sh
# 为文件所有者添加写权限
chmod u+w /path/to/file

# 为文件组添加执行权限
chmod g+x /path/to/file

# 为其他用户移除读取权限
chmod o-r /path/to/file

# 使用数字模式设置权限（例如：755）
chmod 755 /path/to/file
```

### 4.4 修改所有者和组

使用 `chown` 命令来修改文件和目录的所有者和组：

```sh
# 修改文件所有者
sudo chown newowner /path/to/file

# 修改文件所属组
sudo chown :newgroup /path/to/file

# 同时修改文件所有者和组
sudo chown newowner:newgroup /path/to/file
```

## 5. 实用工具

以下是一些在用户和权限管理中非常有用的工具和命令：

### 5.1 sudo

`sudo` 命令允许普通用户以超级用户或其他用户的身份执行命令，主要用于权限管理。

```sh
# 以 root 权限执行命令
sudo command

# 编辑 sudoers 文件以配置 sudo 权限
sudo visudo
```

### 5.2 su

`su` 命令用于切换用户身份，主要用于测试和管理用户权限。

```sh
# 切换到 root 用户
su -

# 切换到其他用户
su username
```

### 5.3 配置 sudo 权限

在使用 `sudo` 命令时，如果遇到以下错误信息：

```bash
We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

xxx is not in the sudoers file.  This incident will be reported.
```

这是因为当前用户不在 `sudoers` 文件中。要解决这个问题，可以使用以下步骤：

#### 切换到 root 用户

```sh
su -
```

#### 编辑 sudoers 文件

使用 `visudo` 命令编辑 `/etc/sudoers` 文件：

```sh
visudo
```

在文件中找到如下行，并添加需要 sudo 权限的用户：

```sh
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
yourusername  ALL=(ALL)       ALL
```

保存并退出编辑器。现在你应该可以使用 `sudo` 命令了。

### 5.4 groups

`groups` 命令用于显示用户所属的组。

```sh
# 显示当前用户所属的组
groups

# 显示指定用户所属的组
groups username
```

## 6. 总结

在这篇文章中，我们介绍了 CentOS 9 的用户和权限管理，包括用户和组的创建、修改和删除，`/etc/passwd` 和 `/etc/group` 文件的介绍，以及文件和目录的权限设置。我们还扩展了硬链接和软链接的创建和使用，并提供了解决 `sudo` 命令权限问题的方法。通过掌握这些知识，你可以更好地控制和管理系统的用户和资源。在接下来的文章中，我们将深入探讨 **软件包管理与系统更新**，敬请期待。
