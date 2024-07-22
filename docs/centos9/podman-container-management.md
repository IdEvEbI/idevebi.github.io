# CentOS 9 实战（13）：Podman 容器管理

欢迎来到《CentOS 9 实战速查手册》专栏的第 13 篇文章。在这里，我们将探讨 **Podman 容器管理**，并详细介绍 **Kubernetes** 以及如何将 **Podman** 与 **Kubernetes** 集成。

## 1. Podman 简介

### 1.1 Podman 的优势

**Podman** 是一个开源的、无守护进程的容器管理工具，具有以下优势：

- **无守护进程**：Podman 不需要运行一个中央守护进程来管理容器。
- **与 Docker 兼容**：Podman 兼容 Docker 命令行接口，可以使用类似的命令来管理容器。
- **运行 Pod**：Podman 支持 Kubernetes 风格的 Pod，可以在本地模拟 Kubernetes 的工作方式。
- **更高的安全性**：Podman 支持 Rootless 模式，允许用户以非特权用户的身份运行容器，提供更高的安全性。

### 1.2 安装 Podman

在 **CentOS 9** 上可以使用以下命令安装 Podman：

```sh
sudo dnf install -y podman
```

### 1.3 Podman 的基本使用

#### 拉取镜像

使用 Podman 拉取镜像：

```sh
podman pull nginx:latest
```

#### 运行容器

使用 Podman 运行容器：

```sh
podman run -d --name mynginx -p 8080:80 nginx:latest
```

#### 查看运行中的容器

查看当前运行的容器：

```sh
podman ps
```

#### 查看所有容器

查看所有容器（包括停止的容器）：

```sh
podman ps -a
```

#### 停止容器

停止一个运行中的容器：

```sh
podman stop mynginx
```

#### 删除容器

删除一个容器：

```sh
podman rm mynginx
```

#### 查看镜像

查看本地存储的镜像：

```sh
podman images
```

#### 删除镜像

删除一个镜像：

```sh
podman rmi nginx:latest
```

## 2. Kubernetes 简介

### 2.1 Kubernetes 的基本概念

**Kubernetes** 是一个开源的容器编排平台，用于自动部署、扩展和管理容器化应用程序。以下是一些关键概念：

- **Pod**：Kubernetes 中的最小部署单元，一个 Pod 包含一个或多个容器。
- **Node**：Kubernetes 集群中的一台机器，可以是物理机或虚拟机。
- **Cluster**：由多个 Node 组成的集群。
- **Deployment**：用于管理 Pod 的声明式定义，支持滚动更新和回滚。
- **Service**：定义一组 Pod 的访问策略，可以通过 Service 将请求负载分发到 Pod。
- **Namespace**：用于隔离集群中的资源和对象。

### 2.2 Kubernetes 的优势

- **自动化部署和管理**：Kubernetes 自动处理容器的部署、复制、伸缩和管理。
- **高可用性**：通过自动重启、自动恢复、自动伸缩等功能，保证应用的高可用性。
- **弹性伸缩**：根据负载自动扩展或缩减容器实例数量。
- **服务发现和负载均衡**：Kubernetes 提供内置的服务发现和负载均衡机制。

### 2.3 安装 Minikube

**Minikube** 是一个用于在本地运行 Kubernetes 的工具，非常适合学习和开发。使用以下命令安装 Minikube：

```sh
# 安装 Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### 2.4 启动 Minikube

使用以下命令启动 Minikube：

```sh
minikube start
```

### 2.5 部署应用

使用以下命令部署一个简单的 Nginx 应用：

```sh
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort
```

## 3. Podman 与 Kubernetes 集成

### 3.1 Podman 生成 Kubernetes YAML

Podman 可以将容器的运行状态导出为 Kubernetes YAML 文件，使用以下命令生成 Kubernetes YAML：

```sh
podman generate kube <container_id> > mypod.yaml
```

### 3.2 使用 Podman 部署 Kubernetes YAML

使用以下命令将生成的 Kubernetes YAML 部署到 Minikube：

```sh
kubectl apply -f mypod.yaml
```

### 3.3 检查部署状态

使用以下命令检查部署状态：

```sh
kubectl get pods
kubectl get services
```

### 3.4 删除部署

使用以下命令删除部署：

```sh
kubectl delete -f mypod.yaml
```

## 4. 实战：使用 Podman 管理容器并与 Kubernetes 集成

### 4.1 拉取镜像并运行容器

```sh
podman pull nginx:latest
podman run -d --name mynginx -p 8080:80 nginx:latest
```

### 4.2 导出容器状态为 Kubernetes YAML

```sh
podman generate kube mynginx > mynginx.yaml
```

### 4.3 部署到 Minikube

```sh
kubectl apply -f mynginx.yaml
```

### 4.4 检查部署状态

```sh
kubectl get pods
kubectl get services
```

### 4.5 测试部署

在浏览器中访问 `http://<minikube_ip>:<node_port>`，确认 Nginx 服务已成功部署。

### 4.6 删除部署

```sh
kubectl delete -f mynginx.yaml
```

## 5. 总结

在这篇文章中，我们介绍了 **Podman** 容器管理工具，以及 **Kubernetes** 的基本概念和优势。我们还探讨了如何将 **Podman** 与 **Kubernetes** 集成，通过实际示例展示了如何使用 **Podman** 生成 **Kubernetes YAML** 并部署到 **Minikube** 上。通过学习这些内容，你可以更好地利用 **Podman** 和 **Kubernetes** 进行容器化应用的管理和编排。
