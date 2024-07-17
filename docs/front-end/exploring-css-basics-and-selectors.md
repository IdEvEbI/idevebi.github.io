# 前端学习日志（2）：CSS 基础与选择器

欢迎来到《前端学习日志》专栏的第 2 篇文章。在本篇文章中，我们将深入探讨 CSS 的基础知识与选择器，并学习如何使用 CSS 来美化和布局网页内容。

## 1. 什么是 CSS？

CSS（Cascading Style Sheets，**层叠样式表**）是一种样式表语言，用于**描述 HTML 文档的外观和格式**。通过使用 CSS，我们可以控制网页的**颜色**、**字体**、**布局**等，使其更加美观和用户友好。

### 1.1 CSS 的基本语法

CSS 的基本语法由**选择器**和**声明块**组成。选择器用于**选中需要应用样式的 HTML 元素**，声明块包含一组用花括号括起来的样式声明，每个声明由**属性**和**值**组成，属性和值之间使用 `:` 分隔并以 `;` 结束。

```css
/* 选择器 */
selector {
  /* 声明块 */
  property: value; /* 声明 */
}
```

示例：

```css
body {
  /* 背景颜色 */
  background-color: lightblue;
}

h1 {
  /* 字体颜色 */
  color: white;
  /* 字体大小 */
  font-size: 20px;
}
```

![CSS 的基本语法](./assets/css-basics-and-selectors/css-basics-syntax.png)

### 1.2 引入 CSS 的方式

我们可以通过三种方式将 CSS 样式引入到 HTML 文档中：

- **行内样式**：在 HTML 元素的 `style` 属性中直接编写 CSS 样式。

```html
<!-- 方式 1：行内样式 -->
<p style="color: red;">这是一个行内样式示例。</p>
```

- **内部样式表**：在 HTML 文档的 `<head>` 标签内使用 `<style>` 标签编写 CSS 样式。

```html
<head>
  <!-- 方式 2：在 HTML 内部定义样式 -->
  <style>
    p {
      color: blue;
    }
  </style>
</head>
```

- **外部样式表**：将 CSS 样式写在独立的 `.css` 文件中，并在 HTML 文档的 `<head>` 标签内使用 `<link>` 标签进行引用。

```html
<head>
  <!-- 方式 3：引入外部样式表 -->
  <link rel="stylesheet" href="style.css">
</head>
```

![CSS 的引入方式](./assets/css-basics-and-selectors/ways-to-include-css.png)

## 2. CSS 选择器

CSS 选择器用于选择需要应用样式的 HTML 元素。常见的选择器包括**元素选择器**、**类选择器**、**ID 选择器**、**属性选择器**、**伪类选择器**，以及各种组合选择器如**后代选择器**、**子选择器**、**相邻兄弟选择器**、**并集选择器**和**通用选择器**等。

### 2.1 元素选择器

**元素选择器**直接选中所有指定的 HTML 元素。

```css
/* 元素选择器 */
p {
  color: green;
}
```

### 2.2 类选择器

**类选择器**选中具有特定类属性的所有 HTML 元素。类选择器以 `.` 开头。

```css
/* 类选择器 */
.highlight {
  background-color: yellow;
}
```

HTML 示例：

```html
<p class="highlight">这是一个高亮段落的类选择器示例。</p>
```

### 2.3 ID 选择器

**ID 选择器**选中具有特定 ID 属性的 HTML 元素。ID 选择器以 `#` 开头。

```css
/* ID 选择器 */
#header {
  background-color: gray;
}
```

HTML 示例：

```html
<div id="header">这是一个 ID 选择器示例。</div>
```

### 2.4 属性选择器

**属性选择器**选中具有特定属性的 HTML 元素。

```css
/* 属性选择器 */
a[target="_blank"] {
  color: red;
}
```

HTML 示例：

```html
<a href="https://www.example.com" target="_blank">这是一个属性选择器示例。</a>
```

### 2.5 伪类选择器

**伪类选择器**用于**选择某些状态下的元素**，例如**鼠标悬停时**的元素。常用的伪类选择器有：

- `:hover`：**鼠标悬停**时的元素。
- `:active`：**元素被激活**时（例如，点击）的状态。
- `:focus`：**元素获得焦点**时的状态。

```css
/* 伪类选择器 */
a:hover {
  color: orange;
}
```

HTML 示例：

```html
<a href="https://www.example.com">这是一个伪类选择器示例。</a>
```

### 2.6 组合选择器

组合选择器包括后代选择器、子选择器、相邻兄弟选择器等，用于选择特定关系的 HTML 元素。

#### 2.6.1 后代选择器

**后代选择器**选中**属于特定父元素的所有后代元素**。

```css
/* 后代选择器 */
div p {
  color: blue;
}
```

HTML 示例：

```html
<div>
  <p>这是一个后代选择器示例。</p>
</div>
```

#### 2.6.2 子选择器

**子选择器**选中**属于特定父元素的直接子元素**。

```css
/* 子选择器 */
ul>li {
  list-style-type: none;
  color: orange;
}
```

HTML 示例：

```html
<ul>
  <li>这是第 1 个子选择器示例。</li>
  <li>这是第 2 个子选择器示例。</li>
  <li>这是第 3 个子选择器示例。</li>
</ul>
```

#### 2.6.3 相邻兄弟选择器

**相邻兄弟选择器**选中**紧接在另一个元素后的元素**。

```css
/* 相邻兄弟选择器 */
h1+p {
  color: pink;
}
```

HTML 示例：

```html
<h1>标题</h1>
<p>这是一个相邻兄弟选择器示例。</p>
<p>隔了一个就不是相邻兄弟元素了。</p>
```

### 2.7 并集选择器

**并集选择器**选中**所有符合任一选择器条件的元素**。选择器之间使用逗号 `,` 分隔。

```css
/* 并集选择器 */
h1,
h2,
h3 {
  color: purple;
}
```

HTML 示例：

```html
<h1>一级标题</h1>
<h2>二级标题</h2>
<h3>三级标题</h3>
```

### 2.8 通用选择器

**通用选择器**选中所有 HTML 元素。通用选择器用 `*` 表示，常用于将所有元素的内、外边距设置为 0，以方便后续的布局工作。

```css
/* 通用选择器 */
* {
  margin: 0;
  padding: 0;
}
```

![CSS 选择器效果](./assets/css-basics-and-selectors/css-selectors.png)

## 3. 字体样式

CSS 可以用于设置字体的样式，包括字体**类型**、**大小**、**颜色**、**加粗**、**斜体**等。

### 3.1 设置字体类型

使用 `font-family` 属性设置**字体类型**。常用的字体类型包括：

- `Arial`、`Helvetica`：**无衬线字体**，适合现代、简洁的设计风格。
- `Times New Roman`、`Georgia`：**衬线字体**，适合正式、传统的设计风格。
- `Courier New`、`Monospace`：**等宽字体**，适合显示代码和技术内容。

```css
p {
  font-family: Arial, sans-serif;
}
```

### 3.2 设置字体大小

使用 `font-size` 属性设置**字体大小**。常用的单位有：

- `px`：像素，绝对单位，适合精确控制字体大小。
- `em`：相对单位，相对于父元素的字体大小，适合响应式设计。
- `rem`：相对单位，相对于根元素的字体大小，适合响应式设计。

```css
h1 {
  font-size: 24px;
}
```

### 3.3 设置字体颜色

使用 `color` 属性设置**字体颜色**。常用的颜色值有：

- 颜色名称，例如 `red`、`blue`。
- 十六进制颜色码，例如 `#ff0000`、`#0000ff`。
- RGB 颜色值，例如 `rgb(255, 0, 0)`、`rgb(0, 0, 255)`。

```css
span {
  color: red;
}
```

### 3.4 设置字体加粗

使用 `font-weight` 属性设置**字体加粗**。常用的属性值有：

- `normal`：正常字体重量。
- `bold`：加粗字体重量。
- `bolder`：更粗的字体重量。
- `lighter`：更细的字体重量。
- 具体的数值，例如 `100`、`200`、`300` 到 `900`。

```css
strong {
  font-weight: bold;
}
```

### 3.5 设置字体斜体

使用 `font-style` 属性设置**字体斜体**。常用的属性值有：

- `normal`：正常字体样式。
- `italic`：斜体样式。
- `oblique`：倾斜样式。

```css
em {
  font-style: italic;
}
```

## 4. 文本样式

CSS 还可以用于设置文本的**对齐方式**、**行高**、**文本装饰**等。

### 4.1 设置文本对齐方式

使用 `text-align` 属性设置文本**对齐方式**。常用的属性值有：

- `left`：左对齐。
- `right`：右对齐。
- `center`：居中对齐。
- `justify`：两端对齐。

```css
h2 {
  text-align: center;
}
```

### 4.2 设置行高

使用 `line-height` 属性设置**行高**。常用的单位有：

- `px`：像素，绝对单位。
- `em`：相对单位，相对于字体大小。

```css
p {
  line-height: 1.5;
}
```

### 4.3 设置文本装饰

使用 `text-decoration` 属性设置**文本装饰**。常用的属性值有：

- `none`：无装饰。
- `underline`：下划线。
- `overline`：上划线。
- `line-through`：删除线。

```css
a {
  text-decoration: underline;
}
```

### 4.4 设置文本缩进

使用 `text-indent` 属性设置**文本缩进**。常用的单位有 `px` 和 `em`。

```css
p {
  text-indent: 2em;
}
```

## 5. 背景样式

CSS 可以用于设置元素的**背景颜色**、**背景图片**等。

### 5.1 设置背景颜色

使用 `background-color` 属性设置元素的背景颜色。常用的颜色值与 `color` 属性相同。

```css
div {
  background-color: lightblue;
}
```

### 5.2 设置背景图片

使用 `background-image` 属性设置元素的**背景图片**。常用的属性值有：

- `url()`：指定背景图片的路径。

```css
div {
  background-image: url('background.jpg');
}
```

### 5.3 设置背景重复

使用 `background-repeat` 属性设置**背景图片的重复方式**。常用的属性值有：

- `repeat`：背景图片在两个方向上重复。
- `repeat-x`：背景图片在水平方向上重复。
- `repeat-y`：背景图片在垂直方向上重复。
- `no-repeat`：背景图片不重复。

```css
div {
  background-repeat: no-repeat;
}
```

### 5.4 设置背景位置

使用 `background-position` 属性设置**背景图片的位置**。常用的属性值有：

- `left top`：背景图片位于左上角。
- `center center`：背景图片位于正中间。
- `right bottom`：背景图片位于右下角。

```css
div {
  background-position: center center;
}
```

### 5.5 设置背景尺寸

使用 `background-size` 属性设置**背景图片的尺寸**。常用的属性值有：

- `auto`：保持背景图片的原始尺寸。
- `cover`：缩放背景图片以完全覆盖元素。
- `contain`：缩放背景图片以适应元素。

```css
div {
  background-size: cover;
}
```

## 6. 实战练习：美化网页内容

接下来，我们将通过一个实战练习来巩固所学知识，使用 CSS 来美化一个简单的网页内容。

首先，在 VS Code 中新建一个 HTML 文件 `beautify-practice.html`，输入以下代码：

```html
<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>美化示例</title>
  <link rel="stylesheet" href="beautify-styles.css">
</head>

<body>
  <header>
    <h1>我的商业网站</h1>
    <nav>
      <ul>
        <li><a href="#home">首页</a></li>
        <li><a href="#about">关于</a></li>
        <li><a href="#services">服务</a></li>
        <li><a href="#contact">联系</a></li>
      </ul>
    </nav>
  </header>
  <main>
    <article>
      <h2>欢迎来到我的网站</h2>
      <p>这是一个商业网站的示例页面，包含多个常见的 HTML 标签。</p>
      <img src="example.jpg" alt="示例图片">
      <p>访问 <a href="https://www.example.com">示例网站</a> 获取更多信息。</p>
      <hr>
      <h3>我们的服务</h3>
      <ul>
        <li>服务1</li>
        <li>服务2</li>
        <li>服务3</li>
      </ul>
      <h3>联系我们</h3>
      <form action="/submit" method="post">
        <label for="name">姓名：</label>
        <input type="text" id="name" name="name">
        <br>
        <label for="message">留言：</label>
        <textarea id="message" name="message"></textarea>
        <br>
        <label for="gender">性别：</label>
        <select id="gender" name="gender">
          <option value="male">男</option>
          <option value="female">女</option>
        </select>
        <br>
        <button type="submit">提交</button>
      </form>
    </article>
    <aside>
      <h2>侧边栏</h2>
      <p>这是侧边栏内容，可以放置广告、链接等。</p>
      <audio controls>
        <source src="audiofile.mp3" type="audio/mp3">
        您的浏览器不支持 audio 标签。
      </audio>
      <video width="320" height="240" controls>
        <source src="videofile.mp4" type="video/mp4">
        您的浏览器不支持 video 标签。
      </video>
    </aside>
  </main>
  <footer>
    <p>版权所有 © 2024</p>
  </footer>
</body>

</html>
```

然后，在 VS Code 中新建一个 CSS 文件 `beautify-styles.css`，输入以下代码：

```css
/* 全局样式 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f9f9f9;
}

/* 标题样式 */
h1, h2 {
  color: #333;
  text-align: center;
}

/* 链接样式 */
a {
  color: #007BFF;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

/* 导航栏样式 */
nav ul {
  list-style-type: none;
  padding: 0;
  text-align: center;
  background-color: #007BFF;
}

nav ul li {
  display: inline;
  margin-right: 15px;
}

nav ul li a {
  color: #fff;
}

/* 主内容区样式 */
main {
  display: flex;
  margin: 20px;
}

article {
  flex: 3;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
}

aside {
  flex: 1;
  padding: 20px;
  margin-left: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #f4f4f4;
}

/* 页脚样式 */
footer {
  padding: 10px;
  text-align: center;
  background-color: #007BFF;
  color: #fff;
}
```

右键点击 `beautify-practice.html` 文件，选择 **Open with Live Server**，浏览器将自动打开并显示文件内容，效果图如下：

![CSS 美化实战案例效果图](./assets/css-basics-and-selectors/css-beautify-practice-case.png)

通过这个实战练习，我们应用了 CSS 的各种样式来美化网页内容，使其看起来更加美观和专业。

## 7. 结语

通过这篇文章，我们了解了 CSS 的**基础知识**和**常用选择器**，并学习了如何使用 CSS 设置**字体样式**、**文本样式**和**背景样式**。掌握这些基础知识是进行前端开发的关键。在接下来的文章中，我们将进一步探索 **CSS 布局与盒模型**，敬请期待。

> - 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
> - **CSS 选择器参考手册**：[CSS 选择器参考手册](https://www.runoob.com/css/css-selector.html)。

**提示**：多实践、多思考，才能更好地掌握 CSS 的各种技巧和应用。
