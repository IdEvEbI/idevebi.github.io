# CentOS 9 实战（15）：KVM 虚拟化与管理

欢迎来到《CentOS 9 实战速查手册》专栏的第 15 篇文章。在这里，我们将探讨 **CentOS 9** 中的 **KVM 虚拟化与管理**。**KVM**（Kernel-based Virtual Machine）是一种开源的虚拟化技术，可以将 **Linux** 系统转化为一个虚拟机监控器（Hypervisor）。通过学习 **KVM** 的安装和配置，你将能够在 **CentOS 9** 上创建和管理虚拟机，为开发、测试和生产环境提供灵活的解决方案。

## 1. 安装和配置 KVM

### 1.1 检查硬件支持

首先，确保你的硬件支持 **KVM**。现代的 **x86** 处理器通常都支持 **KVM**，但你需要确认 **CPU** 是否支持虚拟化扩展（**Intel VT-x** 或 **AMD-V**）。

使用以下命令检查 **CPU** 是否支持虚拟化：

```sh
egrep -o '(vmx|svm)' /proc/cpuinfo
```

如果输出包含 **vmx**（对于 **Intel** 处理器）或 **svm**（对于 **AMD** 处理器），则表示 **CPU** 支持虚拟化。

### 1.2 安装 KVM 和相关工具

使用 **dnf** 命令安装 **KVM** 和相关工具：

```sh
sudo dnf install -y qemu-kvm libvirt libvirt-daemon libvirt-daemon-driver-qemu virt-install virt-manager
```

### 1.3 启动和启用 libvirtd 服务

安装完成后，启动 **libvirtd** 服务并设置为开机自启：

```sh
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```

### 1.4 配置用户权限

为了让普通用户能够管理虚拟机，将用户添加到 **libvirt** 组：

```sh
sudo usermod -aG libvirt $(whoami)
newgrp libvirt
```

## 2. 创建和管理虚拟机

### 2.1 使用 virt-install 创建虚拟机

**virt-install** 是一个命令行工具，用于创建 **KVM** 虚拟机。以下是一个创建虚拟机的示例命令：

```sh
sudo virt-install \
--name centos9-vm \
--ram 2048 \
--disk path=/var/lib/libvirt/images/centos9-vm.img,size=20 \
--vcpus 2 \
--os-type linux \
--os-variant centos8 \
--network bridge=virbr0 \
--graphics none \
--console pty,target_type=serial \
--location 'http://mirror.centos.org/centos/9-stream/BaseOS/x86_64/os/' \
--extra-args 'console=ttyS0,115200n8 serial'
```

### 2.2 使用 virt-manager 图形化管理虚拟机

**virt-manager** 是一个图形化工具，用于管理 **KVM** 虚拟机。启动 **virt-manager** 并使用它创建和管理虚拟机：

```sh
virt-manager
```

在 **virt-manager** 界面中，你可以通过向导创建虚拟机，配置虚拟机的硬件资源，以及管理虚拟机的生命周期（启动、暂停、关闭等）。

### 2.3 使用 virsh 管理虚拟机

**virsh** 是一个命令行工具，用于管理 **KVM** 虚拟机。以下是一些常用的 **virsh** 命令：

```sh
# 列出所有虚拟机
virsh list --all

# 启动虚拟机
virsh start centos9-vm

# 关闭虚拟机
virsh shutdown centos9-vm

# 强制关闭虚拟机
virsh destroy centos9-vm

# 删除虚拟机
virsh undefine centos9-vm --remove-all-storage
```

## 3. 网络配置

### 3.1 使用默认的虚拟网络

**KVM** 默认提供一个名为 **virbr0** 的虚拟网络桥接，可以直接用于虚拟机的网络连接。虚拟机连接到 **virbr0** 后，可以访问外部网络，并且外部网络也可以访问虚拟机。

### 3.2 创建自定义的虚拟网络

你可以创建自定义的虚拟网络，以满足不同的网络需求。以下是一个创建自定义虚拟网络的示例：

```xml
<network>
  <name>custom-net</name>
  <bridge name='virbr1' stp='on' delay='0'/>
  <ip address='192.168.100.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.100.100' end='192.168.100.200'/>
    </dhcp>
  </ip>
</network>
```

保存上述配置为 **custom-net.xml**，然后使用以下命令创建自定义虚拟网络：

```sh
sudo virsh net-define custom-net.xml
sudo virsh net-start custom-net
sudo virsh net-autostart custom-net
```

### 3.3 配置虚拟机使用自定义网络

在创建或修改虚拟机时，指定使用自定义网络：

```sh
--network network=custom-net
```

## 4. 存储配置

### 4.1 创建存储池

**KVM** 使用存储池来管理虚拟机的磁盘镜像。以下是一个创建存储池的示例：

```sh
sudo virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images
sudo virsh pool-start default
sudo virsh pool-autostart default
```

### 4.2 创建存储卷

在存储池中创建存储卷，用于虚拟机的磁盘：

```sh
sudo virsh vol-create-as default centos9-vm.img 20G
```

## 5. 快照和备份

### 5.1 创建快照

快照用于保存虚拟机的当前状态，以便将来恢复：

```sh
sudo virsh snapshot-create-as centos9-vm snapshot1
```

### 5.2 恢复快照

从快照恢复虚拟机状态：

```sh
sudo virsh snapshot-revert centos9-vm snapshot1
```

### 5.3 备份虚拟机

关闭虚拟机后，可以使用 **rsync** 或 **scp** 备份虚拟机的磁盘镜像：

```sh
sudo rsync -av /var/lib/libvirt/images/centos9-vm.img /backup/
```

## 6. 总结

在这篇文章中，我们介绍了 **CentOS 9** 中的 **KVM 虚拟化与管理**，包括 **KVM** 的安装、配置、虚拟机的创建与管理、网络配置、存储配置、快照和备份。通过掌握这些知识，你可以在 **CentOS 9** 上高效地创建和管理虚拟机，为你的开发、测试和生产环境提供灵活的解决方案。在接下来的文章中，我们将深入探讨 **Docker 容器化应用**，敬请期待。
