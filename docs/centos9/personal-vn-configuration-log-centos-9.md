# CentOS 9 虚拟机安装记录

## 1. 使用 VMware Fusion 安装虚拟机

### 1.1 下载 CentOS 9 镜像

从 [CentOS 官方网站](https://www.centos.org/download/) 下载 CentOS 9 的 ISO 镜像。

### 1.2 创建虚拟机

1. 打开 VMware Fusion，选择 `创建新虚拟机`。
2. 选择 `安装程序光盘镜像文件 (iso)`，并选择下载的 CentOS 9 ISO 文件。
3. 点击 `继续`，选择 `CentOS 9` 作为操作系统。
4. 为虚拟机分配资源（如内存、CPU、磁盘空间等），建议至少分配 2GB 内存和 20GB 磁盘空间。
5. 点击 `完成` 创建虚拟机。

### 1.3 启动虚拟机并安装 CentOS 9

1. 启动虚拟机，进入 CentOS 9 安装界面。
2. 选择 `安装 CentOS 9` 进入安装程序。
3. 选择语言和键盘布局，点击 `继续`。
4. 在 `安装源` 中选择 `本地媒体`。
5. 在 `软件选择` 中选择 `最小安装`。
6. 在 `安装位置` 中选择虚拟硬盘，点击 `完成`。
7. 在 `网络和主机名` 中启用网络接口并设置主机名。
8. 点击 `开始安装`，在安装过程中设置 `Root 密码` 和 `创建用户`。
9. 安装完成后，点击 `重新启动`。

## 2. 更新 dnf，安装常用软件

1. 更新系统

   ```sh
   sudo dnf update -y
   ```

2. 安装常用软件

   ```sh
   sudo dnf install -y wget curl git net-tools vim
   ```

## 3. 添加新用户

1. 添加新用户

   ```sh
   sudo adduser newuser
   sudo passwd newuser
   ```

2. 将新用户添加到 sudoers

   ```sh
   sudo usermod -aG wheel newuser
   ```

3. 编辑 SSH 配置文件

   ```sh
   sudo vim /etc/ssh/sshd_config
   ```

4. 确保以下配置项被启用或添加：

   ```sh
   PermitRootLogin no
   ```

5. 重启 SSH 服务

   ```sh
   # 重启 sshd 服务
   sudo systemctl restart sshd
   ```

6. 在客户端机器上生成 SSH 密钥对：

   ```sh
   # 生成 SSH 密钥对
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

7. 将公钥添加到服务器

   ```sh
   # 在客户端机器上，将公钥复制到服务器
   ssh-copy-id -i ~/.ssh/id_rsa.pub user@server_address
   ```

## 4. 安装 Docker

### 4.1 安装 Docker

1. 安装 Docker 所需的软件包

   ```sh
   sudo dnf install -y dnf-plugins-core yum-utils
   ```

2. 指定国内代理镜像，设置 Docker 仓库

   ```sh
   sudo tee /etc/yum.repos.d/docker-ce.repo <<-'EOF'
   [docker-ce-stable]
   name=Docker CE Stable - $basearch
   baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/9/$basearch/stable
   enabled=1
   gpgcheck=1
   gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg
   EOF
   ```

3. 安装 Docker

   ```sh
   sudo dnf install -y docker-ce docker-ce-cli containerd.io
   ```

4. 启动并启用 Docker

   ```sh
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

5. 配置镜像加速器

   ```sh
   sudo mkdir -p /etc/docker
   sudo tee /etc/docker/daemon.json <<-'EOF'
   {
     "registry-mirrors": ["https://your-id.mirror.aliyuncs.com"]
   }
   EOF
   
   sudo systemctl daemon-reload
   sudo systemctl restart docker
   ```

6. 验证 Docker 安装

   ```sh
   sudo docker run hello-world
   ```

### 4.2 安装 MySQL Docker

1. 拉取 MySQL 镜像

   ```sh
   sudo docker pull mysql:latest
   ```

2. 运行 MySQL 容器

   ```sh
   sudo docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -d -p 3306:3306 mysql:latest
   ```

3. 验证 MySQL 容器

   ```sh
   sudo docker ps
   ```

### 4.3 允许从主机访问 MySQL

1. 配置防火墙以允许 MySQL 端口访问

   ```sh
   sudo firewall-cmd --permanent --add-port=3306/tcp
   sudo firewall-cmd --reload
   ```

2. 连接到 MySQL 容器并配置远程访问

   ```sh
   sudo docker exec -it mysql-container mysql -uroot -p
   ```

3. 在 MySQL shell 中运行以下命令：

   ```sql
   CREATE USER 'remote_user'@'%' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON *.* TO 'remote_user'@'%' WITH GRANT OPTION;
   FLUSH PRIVILEGES;
   ```

4. 重新启动之前的 MySQL 容器

   ```sh
   sudo docker start mysql-container
   ```

至此，我的 CentOS 9 虚拟机就配置好了 Docker 和 MySQL 环境，并且允许从主机远程访问 MySQL。
