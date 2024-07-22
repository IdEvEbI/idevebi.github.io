# CentOS 9 实战（12）：Docker 容器化应用

欢迎来到《CentOS 9 实战速查手册》专栏的第 12 篇文章。在这里，我们将探讨 **Docker 容器化应用**，包括 **Docker** 的基本概念和工作流程，以及在 **CentOS 9** 上安装和使用 **Docker** 的具体步骤。

## 1. Docker 的基本概念和流程

### 1.1 Docker 基本概念

**Docker** 是一种开源的容器化平台，能够将应用程序及其依赖打包到一个可移植的容器中，然后可以在任何支持 Docker 的系统上运行。Docker 容器相比传统的虚拟机更加轻量，启动速度快，占用资源少。

### 1.2 Docker 的基本流程

以下是使用 Docker 的基本流程：

1. **拉取镜像**：从 Docker Hub 或其他镜像仓库中拉取一个基础镜像，例如 `ubuntu:latest`。
2. **运行容器**：基于拉取的镜像运行一个容器。这个容器相当于一个轻量级、隔离的操作系统实例。
3. **在容器中安装和部署软件**：在运行的容器中，你可以根据开发需求安装和配置各种软件和依赖。例如，在 Ubuntu 容器中安装 Vim、Apache 或其他软件。
4. **保存容器状态为新镜像**：对容器进行配置和软件安装后，可以将容器保存为新的镜像。这一步通常使用 `docker commit` 命令将容器的当前状态保存为镜像。
5. **保存镜像到本地文件**：将创建好的镜像保存为本地文件，通常使用 `docker save` 命令。
6. **推送镜像到 Docker Hub**：将镜像推送到 Docker Hub 或其他镜像仓库，使用 `docker push` 命令。这样，你就可以在其他机器上方便地拉取这个镜像。
7. **在其他主机上部署**：在其他主机上，从 Docker Hub 拉取镜像，基于这个镜像运行新的容器，实现快速部署。

## 2. 安装 Docker

### 2.1 卸载旧版本

在安装新版本 Docker 之前，建议卸载任何旧版本：

```sh
sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
```

### 2.2 安装所需软件包

安装一些必要的软件包以便于通过 HTTPS 进行仓库访问：

```sh
sudo dnf install -y yum-utils
```

### 2.3 添加 Docker 仓库

添加 Docker 的官方仓库：

```sh
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### 2.4 安装 Docker

使用以下命令安装 Docker：

```sh
sudo dnf install -y docker-ce docker-ce-cli containerd.io
```

### 2.5 启动 Docker 并设置开机自启动

启动 Docker 服务，并将其设置为开机自启动：

```sh
sudo systemctl start docker
sudo systemctl enable docker
```

### 2.6 检查 Docker 安装状态

使用以下命令检查 Docker 是否安装成功：

```sh
sudo docker run hello-world
```

### 2.7 配置 Docker 镜像加速

可以使用阿里云的 Docker 镜像加速地址，编辑或创建 `/etc/docker/daemon.json` 文件，添加如下内容：

```json
{
  "registry-mirrors": ["https://<your-accelerator-url>"]
}
```

### 2.8 再次测试 Docker

使用以下命令测试 Docker 是否安装成功：

```sh
sudo docker run hello-world
```

如果看到以下输出，说明 Docker 安装成功：

```plaintext
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

## 3. Docker 基本操作

### 3.1 拉取镜像

使用 `docker pull` 命令从 Docker Hub 拉取一个镜像，例如：

```sh
sudo docker pull ubuntu:latest
```

拉取的镜像会保存在本地的 Docker 镜像库中，可以使用以下命令查看已拉取的镜像：

```sh
sudo docker images
```

### 3.2 运行容器

使用 `docker run` 命令基于拉取的镜像运行一个容器，例如运行一个 Ubuntu 容器：

```sh
sudo docker run -it ubuntu:latest bash
```

### 3.3 查看容器 ID

使用 `docker ps` 命令查看正在运行的容器及其 ID：

```sh
sudo docker ps
```

输出示例：

```plaintext
CONTAINER ID   IMAGE          COMMAND       CREATED          STATUS          PORTS     NAMES
abc123         ubuntu:latest  "bash"        10 minutes ago   Up 10 minutes             friendly_fermi
```

### 3.4 进入正在运行的容器

使用 `docker exec` 命令进入正在运行的容器，以便进行进一步的配置和操作：

```sh
sudo docker exec -it abc123 bash
```

### 3.5 保存容器状态为新镜像

配置完容器后，可以将其保存为新的镜像：

```sh
sudo docker commit abc123 my_custom_ubuntu
```

### 3.6 保存镜像到本地文件

使用 `docker save` 命令将镜像保存为本地文件：

```sh
sudo docker save -o my_custom_ubuntu.tar my_custom_ubuntu
```

### 3.7 推送镜像到 Docker Hub

首先需要登录 Docker Hub：

```sh
sudo docker login
```

然后将镜像推送到 Docker Hub：

```sh
sudo docker tag my_custom_ubuntu your_dockerhub_username/my_custom_ubuntu
sudo docker push your_dockerhub_username/my_custom_ubuntu
```

### 3.8 在其他主机上部署

在其他主机上，从 Docker Hub 拉取镜像并运行容器：

```sh
sudo docker pull your_dockerhub_username/my_custom_ubuntu
sudo docker run -it your_dockerhub_username/my_custom_ubuntu bash
```

### 3.9 根据 ID 进入容器

你可以根据容器 ID 进入正在运行的容器，方便对容器进行继续配置：

```sh
sudo docker exec -it <container_id> bash
```

## 4. Docker Compose

### 4.1 Docker Compose 简介

**Docker Compose** 是一个用于定义和运行多容器 Docker 应用程序的工具。通过使用 Docker Compose，可以在一个 YAML 文件中配置应用程序的服务，然后通过简单的命令就可以启动、停止和管理这些服务。

### 4.2 安装 Docker Compose

使用以下命令在 **CentOS 9** 上安装 Docker Compose：

```sh
sudo dnf install -y docker-compose
```

### 4.3 创建 Docker Compose 文件

创建一个名为 `docker-compose.yml` 的文件，定义你的应用程序服务。例如，以下是一个简单的 Docker Compose 文件，它定义了一个使用 MySQL 数据库的 WordPress 服务：

```yaml
version: '3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example

  wordpress:
    image: wordpress:latest
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_PASSWORD: example
volumes:
  db_data:
```

### 4.4 启动服务

在包含 `docker-compose.yml` 文件的目录中，使用以下命令启动服务：

```sh
sudo docker-compose up -d
```

### 4.5 查看服务状态

使用以下命令查看服务的运行状态：

```sh
sudo docker-compose ps
```

### 4.6 停止服务

使用以下命令停止服务：

```sh
sudo docker-compose down
```

## 5. 在 Docker Hub 上查找和下载镜像

访问 [Docker Hub](https://hub.docker.com/) 网站，使用搜索功能查找所需的镜像。Docker Hub 提供了各种官方和社区维护的镜像，可以根据需求选择适合的镜像进行下载和使用。
