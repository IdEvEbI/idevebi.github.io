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
