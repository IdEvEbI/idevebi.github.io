# SwiftUI 学习日志：为 SwiftUI 网络请求专题准备后台服务

在本篇文章中，咱们将通过使用 Node.js 构建一个简单的后台服务，为下一篇关于《SwiftUI 网络请求与数据处理》的专题文章做准备。这个后台服务将支持：**GET 请求**、**POST 请求**、**表单提交**、**文件上传**、**头像上传**、**文件下载**等功能，并支持**返回复杂的 JSON 数据**，以方便在后续专栏中做复杂的数据解析。通过这篇文章，你将了解如何安装和配置 Node.js，并使用 Express 框架和其他中间件来构建你的后台服务。

## 1. Node.js 的安装和校验

### 1.1 安装 Node.js

前往 [Node.js 官网](https://nodejs.org/) 下载并安装适用于你操作系统的 Node.js 版本。安装完成后，可以通过终端（或命令提示符）检查 Node.js 是否安装成功。

```bash
node -v
npm -v
```

上述命令会显示已安装的 Node.js 和 npm 版本号，表明安装成功。

### 1.2 创建项目目录

在终端中，创建一个新的项目目录并初始化一个新的 Node.js 项目。

```bash
mkdir swiftui-backend
cd swiftui-backend
npm init -y
```

## 2. 安装所需依赖

在项目目录中，安装 `Express`、`body-parser`、`multer`、`crypto` 和 `cors`。

```bash
npm install express body-parser multer crypto cors
```

- **Express**：一个快速、简洁的 Node.js Web 框架。
- **body-parser**：用于解析请求体，支持 JSON 和 URL 编码的数据。
- **multer**：用于处理 multipart/form-data 类型的表单数据，主要用于文件上传。
- **crypto**：用于生成文件的 MD5 哈希值。
- **cors**：用于解决跨域访问。

## 3. 创建服务器

在项目目录中新建 `server.js` 文件，并输入以下代码：

```javascript
const express = require('express');
const bodyParser = require('body-parser');
const multer = require('multer');
const crypto = require('crypto');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

// 使用 CORS 中间件
app.use(cors());

// 使用 body-parser 解析 JSON 和 URL 编码的数据
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 配置 multer 用于文件上传
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        const hash = crypto.createHash('md5').update(file.originalname + Date.now()).digest('hex');
        const ext = path.extname(file.originalname);
        cb(null, `${hash}${ext}`);
    }
});

const upload = multer({ storage: storage });

// 创建 uploads 目录（如果不存在）
if (!fs.existsSync('uploads')) {
    fs.mkdirSync('uploads');
}

// GET 请求示例
app.get('/api/data', (req, res) => {
    res.json({ message: '这是一个 GET 请求返回的数据' });
});

// POST 请求示例
app.post('/api/data', (req, res) => {
    const { name, email } = req.body;
    res.json({ message: `接收到的 POST 请求数据：姓名 - ${name}, 邮箱 - ${email}` });
});

// 表单提交示例
app.post('/api/form', (req, res) => {
    const { username, password } = req.body;
    res.json({ message: `表单提交成功：用户名 - ${username}, 密码 - ${password}` });
});

// 文件上传示例
app.post('/api/upload', upload.single('file'), (req, res) => {
    res.json({ message: '文件上传成功', filename: req.file.filename });
});

// 头像上传示例
app.post('/api/avatar', upload.single('avatar'), (req, res) => {
    res.json({ message: '头像上传成功', filename: req.file.filename });
});

// 文件下载示例
app.get('/api/download/:filename', (req, res) => {
    const { filename } = req.params;
    const filepath = path.join(__dirname, 'uploads', filename);
    if (fs.existsSync(filepath)) {
        res.download(filepath);
    } else {
        res.status(404).json({ message: '文件未找到' });
    }
});

// 返回复杂 JSON 数据的 GET 请求
app.get('/api/complex-data', (req, res) => {
    res.json({
        slideshow: {
            author: "张三",
            date: "2023-01-01",
            slides: [
                {
                    title: "欢迎使用 Widget",
                    type: "all"
                },
                {
                    title: "Widget 概览",
                    type: "all",
                    items: [
                        "Widget 的优点",
                        "谁在使用 Widget"
                    ]
                }
            ],
            title: "示例幻灯片"
        }
    });
});

// 返回复杂 JSON 数据的 POST 请求
app.post('/api/complex-data', (req, res) => {
    res.json({
        status: "success",
        data: {
            user: {
                name: req.body.name,
                age: req.body.age,
                email: req.body.email
            },
            message: "数据处理成功"
        }
    });
});

// 处理 404
app.use((req, res, next) => {
    res.status(404).send('页面未找到');
});

app.listen(PORT, () => {
    console.log(`服务器正在运行在 http://localhost:${PORT}`);
});
```

## 4. 创建测试 HTML 文件

在项目目录中新建 `index.html` 文件，并输入以下代码：

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>测试页面</title>
</head>
<body>
  <h1>测试 GET 请求</h1>
  <button onclick="testGetRequest()">发送 GET 请求</button>
  <pre id="getResponse"></pre>

  <h1>测试 POST 请求</h1>
  <form id="postForm">
    <label for="name">姓名:</label>
    <input type="text" id="name" name="name"><br>
    <label for="email">邮箱:</label>
    <input type="email" id="email" name="email"><br>
    <button type="button" onclick="testPostRequest()">发送 POST 请求</button>
  </form>
  <pre id="postResponse"></pre>

  <h1>测试表单提交</h1>
  <form id="formSubmit">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username"><br>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password"><br>
    <button type="button" onclick="testFormSubmit()">提交表单</button>
  </form>
  <pre id="formResponse"></pre>

  <h1>测试文件上传</h1>
  <form id="uploadForm">
    <label for="file">选择文件:</label>
    <input type="file" id="file" name="file"><br>
    <button type="button" onclick="testFileUpload()">上传文件</button>
  </form>
  <pre id="uploadResponse"></pre>

  <h1>测试头像上传</h1>
  <form id="avatarForm">
    <label for="avatar">选择头像:</label>
    <input type="file" id="avatar" name="avatar"><br>
    <button type="button" onclick="testAvatarUpload()">上传头像</button>
  </form>
  <pre id="avatarResponse"></pre>

  <h1>测试文件下载</h1>
  <input type="text" id="filename" placeholder="输入文件名"><br>
  <button onclick="testFileDownload()">下载文件</button>

  <h1>测试复杂 JSON 数据 (GET)</h1>
  <button onclick="testComplexGetRequest()">发送 GET 请求</button>
  <pre id="complexGetResponse"></pre>

  <h1>测试复杂 JSON 数据 (POST)</h1>
  <form id="complexPostForm">
    <label for="postName">姓名:</label>
    <input type="text" id="postName" name="name"><br>
    <label for="postAge">年龄:</label>
    <input type="text" id="postAge" name="age"><br>
    <label for="postEmail">邮箱:</label>
    <input type="email" id="postEmail" name="email"><br>
    <button type="button" onclick="testComplexPostRequest()">发送 POST 请求</button>
  </form>
  <pre id="complexPostResponse"></pre>

  <script>
    function testGetRequest() {
      fetch('http://localhost:3000/api/data')
        .then(response => response.json())
        .then(data =>

 document.getElementById('getResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testPostRequest() {
      const form = document.getElementById('postForm');
      const formData = new FormData(form);
      const jsonData = {};
      formData.forEach((value, key) => {
        jsonData[key] = value;
      });

      fetch('http://localhost:3000/api/data', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(jsonData)
      })
        .then(response => response.json())
        .then(data => document.getElementById('postResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testFormSubmit() {
      const form = document.getElementById('formSubmit');
      const formData = new FormData(form);
      const jsonData = {};
      formData.forEach((value, key) => {
        jsonData[key] = value;
      });

      fetch('http://localhost:3000/api/form', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(jsonData)
      })
        .then(response => response.json())
        .then(data => document.getElementById('formResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testFileUpload() {
      const form = document.getElementById('uploadForm');
      const formData = new FormData(form);

      fetch('http://localhost:3000/api/upload', {
        method: 'POST',
        body: formData
      })
        .then(response => response.json())
        .then(data => document.getElementById('uploadResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testAvatarUpload() {
      const form = document.getElementById('avatarForm');
      const formData = new FormData(form);

      fetch('http://localhost:3000/api/avatar', {
        method: 'POST',
        body: formData
      })
        .then(response => response.json())
        .then(data => document.getElementById('avatarResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testFileDownload() {
      const filename = document.getElementById('filename').value;

      fetch(`http://localhost:3000/api/download/${filename}`)
        .then(response => response.blob())
        .then(blob => {
          const url = window.URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.style.display = 'none';
          a.href = url;
          a.download = filename;
          document.body.appendChild(a);
          a.click();
          window.URL.revokeObjectURL(url);
        })
        .catch(err => console.error('下载出错:', err));
    }

    function testComplexGetRequest() {
      fetch('http://localhost:3000/api/complex-data')
        .then(response => response.json())
        .then(data => document.getElementById('complexGetResponse').textContent = JSON.stringify(data, null, 2));
    }

    function testComplexPostRequest() {
      const form = document.getElementById('complexPostForm');
      const formData = new FormData(form);
      const jsonData = {};
      formData.forEach((value, key) => {
        jsonData[key] = value;
      });

      fetch('http://localhost:3000/api/complex-data', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(jsonData)
      })
        .then(response => response.json())
        .then(data => document.getElementById('complexPostResponse').textContent = JSON.stringify(data, null, 2));
    }
  </script>
</body>
</html>
```

## 5. 启动服务器

在终端中，运行以下命令以启动服务器：

```bash
node server.js
```

此时，服务器将在 `http://localhost:3000` 运行，然后在浏览器中打开 `index.html` 可以测试对应的网络请求。

## 6. 结语

通过这篇文章，我们介绍了如何使用 Node.js 和 Express 创建一个简单的后台服务，并实现了多种网络请求和数据处理功能。这为后续的 SwiftUI 应用中的网络请求与数据处理提供了支持。敬请期待下一篇专栏文章，我们将深入探讨 SwiftUI 中的网络请求与数据处理。
