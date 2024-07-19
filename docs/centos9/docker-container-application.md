# CentOS 9 实战（12）：Docker 容器化应用

欢迎来到《CentOS 9 实战速查手册》专栏的第 12 篇文章。在这里，我们将深入探讨 **Docker 容器化应用**。Docker 是一个开源的容器化平台，允许开发人员和运维人员轻松地创建、部署和运行应用程序。通过学习 Docker 的安装和使用，你可以提升应用的开发和运维效率。

## 1. Docker 简介

**Docker** 是一个开源的容器化平台，提供了一个轻量级的虚拟化解决方案。与传统的虚拟机不同，Docker 容器共享主机的操作系统内核，这使得容器启动更快，占用资源更少。

### 1.1 Docker 的优势

- **快速部署**：Docker 容器可以在几秒钟内启动，大大提高了应用的部署速度。
- **一致的运行环境**：通过 Docker，开发和生产环境可以保持一致，减少环境差异带来的问题。
- **高效的资源利用**：Docker 容器共享主机的操作系统资源，比虚拟机更加轻量级。
- **易于扩展和管理**：通过 Docker Compose 和 Kubernetes 等工具，Docker 容器的编排和管理变得更加简单。

## 2. Docker 安装

在 **CentOS 9** 中，我们将使用阿里云的 Docker 镜像源来安装 Docker，以解决网络连接问题。

### 2.1 删除现有 Docker 源

如果之前已经添加过 Docker 官方仓库源，可以先将其删除：

```sh
sudo rm -f /etc/yum.repos.d/docker-ce.repo
```

### 2.2 添加阿里云 Docker 源

创建一个新的 Docker 源配置文件：

```sh
sudo vim /etc/yum.repos.d/docker-ce.repo
```

添加以下内容到文件中：

```ini
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/9/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg
```

保存并关闭文件。

### 2.3 安装 Docker

使用新的镜像源安装 Docker：

```sh
sudo dnf install -y docker-ce docker-ce-cli containerd.io --nobest
```

### 2.4 启动和启用 Docker 服务

```sh
sudo systemctl start docker
sudo systemctl enable docker
```

### 2.5 检查 Docker 版本

验证 Docker 是否正确安装：

```sh
docker --version
```

### 2.6 配置用户权限

为了让普通用户能够使用 Docker，将用户添加到 docker 组：

```sh
sudo usermod -aG docker $(whoami)
newgrp docker
```

### 2.7 配置 Docker 镜像加速

为提高 Docker 镜像的下载速度，可以配置镜像加速器。在 `/etc/docker/daemon.json` 文件中添加以下内容：

```json
{
  "registry-mirrors": ["https://<your_id>.mirror.aliyuncs.com"]
}
```

将 `<your_id>` 替换为你的阿里云加速器 ID。你可以在阿里云控制台中找到这个 ID。

保存文件后，重启 Docker 服务：

```sh
sudo systemctl restart docker
```

### 2.8 测试 Docker

使用 Docker 运行一个测试容器，验证安装和配置是否成功：

```sh
docker run hello-world
```

成功运行后，你将看到如下信息：

```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## 3. Docker 基本操作

### 3.1 拉取镜像

从 Docker Hub 拉取一个镜像：

```sh
docker pull ubuntu:latest
```

### 3.2 运行容器

运行一个 Docker 容器：

```sh
docker run -it ubuntu:latest /bin/bash
```

在这条命令中：

- **`-it`**：表示以交互模式运行容器，并连接到容器的终端。
- **`ubuntu:latest`**：表示使用 Ubuntu 最新版本的镜像。
- **`/bin/bash`**：表示运行容器后执行 `/bin/bash`，进入容器的命令行。

在容器中，你可以像在普通的 Linux 系统中一样执行命令。例如，安装一个软件包：

```sh
apt update
apt install -y vim
```

安装完成后，你可以使用 `vim` 编辑文件。退出容器命令行时，可以输入 `exit`。

### 3.3 列出容器

列出所有正在运行的容器：

```sh
docker ps
```

列出所有容器（包括未运行的）：

```sh
docker ps -a
```

### 3.4 停止和删除容器

停止一个正在运行的容器：

```sh
docker stop <container_id>
```

删除一个容器：

```sh
docker rm <container_id>
```

### 3.5 查看日志

查看容器的日志：

```sh
docker logs <container_id>
```

### 3.6 进入运行中的容器

进入一个正在运行的容器：

```sh
docker exec -it <container_id> /bin/bash
```

在这里，`<container_id>` 是容器的 ID，通过 `docker ps` 命令可以获取。

### 3.7 保存和加载镜像

保存一个镜像到本地文件：

```sh
docker save -o ubuntu_latest.tar ubuntu:latest
```

从本地文件加载一个镜像：

```sh
docker load -i ubuntu_latest.tar
```

### 3.8 推送镜像到 Docker Hub

登录 Docker Hub：

```sh
docker login
```

标记镜像：

```sh
docker tag ubuntu:latest your_dockerhub_username/ubuntu:latest
```

推送镜像到 Docker Hub：

```sh
docker push your_dockerhub_username/ubuntu:latest
```

## 4. Docker Compose

**Docker Compose** 是一个用于定义和运行多容器 Docker 应用程序的工具。你可以使用 YAML 文件来配置应用程序需要的所有服务。

### 4.1 安装 Docker Compose

在 **CentOS 9** 中，可以使用以下命令来安装 Docker Compose：

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 4.2 创建 Docker Compose 文件

创建一个名为 `docker-compose.yml` 的文件：

```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: example
```

### 4.3 启动应用

使用 Docker Compose 启动应用：

```sh
docker-compose up -d
```

### 4.4 停止应用

使用 Docker Compose 停止应用：

```sh
docker-compose down
```

## 5. Kubernetes 简介

**Kubernetes**（简称 K8s）是一个开源的容器编排平台，用于自动化应用程序的部署、扩展和管理。Kubernetes 提供了一个集中的平台，可以帮助你轻松管理多个容器。

### 5.1 Kubernetes 的优势

- **自动化部署和管理**：Kubernetes 可以自动部署和管理容器化应用，简化运维流程。
- **弹性伸缩**：Kubernetes 提供了弹性伸缩功能，可以根据负载自动扩展或缩减容器数量。
- **服务发现和负载均衡**：Kubernetes 内置服务发现和负载均衡功能，确保应用的高可用性和稳定性。
- **自我修复**：Kubernetes 可以自动监控应用的运行状态，自动重启失败的容器，确保应用的持续运行。

### 5.2 安装 Kubernetes

Kubernetes 的安装可以使用 `kubectl` 和 `minikube` 工具。这里以 `minikube` 为例：

#### 安装 kubectl

```sh
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### 安装 Minikube

```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
```

#### 启动 Minikube

```sh
minikube start
```

### 5.3 使用 Kubernetes 部署应用

创建一个部署文件 `deployment.yaml`：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

使用 kubectl 创建部署：

```sh
kubectl apply -f deployment.yaml
```

查看部署状态：

```sh
kubectl get deployments
kubectl get pods
```

## 6. 总结

在这篇文章中，我们介绍了 **Docker 容器化应用** 的基本概念、安装步骤以及常见操作。我们还简要介绍了 Kubernetes，这个强大的容器编排平台，可以帮助你在大规模环境中管理容器化应用。在接下来的文章中，我们将深入探讨 **Podman 容器管理**，敬请期待。
