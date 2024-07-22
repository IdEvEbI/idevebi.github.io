# CentOS 9 实战速查手册：Vim 从入门到进阶

欢迎来到《CentOS 9 实战速查手册》专栏的扩展阅读文章。在这篇文章中，我们将深入探讨 **Vim 的基本使用**及**常见配置**，帮助你将 Vim 配置成一个强大的 IDE，适用于 C 语言和 Python 的开发环境。

## 1. Vim 简介

**Vim**（Vi IMproved）是从 vi 发展出来的一个文本编辑器，拥有许多增强功能，如**多级撤销**、**语法高亮**、**文件名补全**和**丰富的插件系统**等。Vim 被广泛应用于程序开发、系统管理等领域。

## 2. Vim 基本使用

### 2.1 安装 Vim

在 **CentOS 9** 中，使用以下命令安装 Vim：

```sh
sudo dnf install -y vim
```

在 **MacOS** 中，使用 Homebrew 安装 Vim：

```sh
brew install vim
```

在 **Ubuntu** 中，使用以下命令安装 Vim：

```sh
sudo apt-get install -y vim
```

### 2.2 启动 Vim

```sh
vim filename
```

### 2.3 模式切换

- **普通模式**：按 `Esc` 键切换到普通模式。
- **插入模式**：按 `i` 键进入插入模式。
- **可视模式**：按 `v` 键进入可视模式。
- **命令模式**：在普通模式下按 `:` 键进入命令模式。

## 3. Vim 常用快捷键

### 3.1 移动光标

- `h`：左移一个字符。
- `j`：下移一行。
- `k`：上移一行。
- `l`：右移一个字符。
- `w`：移动到下一个单词的开头。
- `b`：移动到上一个单词的开头。
- `e`：移动到单词的结尾。
- `0`：移动到行首。
- `$`：移动到行尾。

### 3.2 编辑文本

- `i`：在光标前插入。
- `I`：在行首插入。
- `a`：在光标后插入。
- `A`：在行尾插入。
- `o`：在当前行下方新建一行并进入插入模式。
- `O`：在当前行上方新建一行并进入插入模式。
- `x`：删除光标下的字符。
- `dd`：删除整行。
- `yy`：复制整行。
- `p`：在光标后粘贴。
- `u`：撤销操作。
- `Ctrl + r`：重做操作。

### 3.3 查找和替换

- `/pattern`：向下查找 `pattern`。
- `?pattern`：向上查找 `pattern`。
- `n`：查找下一个匹配。
- `N`：查找上一个匹配。
- `:s/old/new/g`：将当前行的 `old` 替换为 `new`。
- `:%s/old/new/g`：将整个文件的 `old` 替换为 `new`。

### 3.4 文件操作

- `:w`：保存文件。
- `:q`：退出 Vim。
- `:wq`：保存并退出。
- `:q!`：强制退出不保存。
- `:e filename`：打开文件 `filename`。

### 3.5 可视模式

- `v`：进入可视模式。
- `V`：选择整行。
- `Ctrl + v`：进入块选择模式。
- `y`：复制选中内容。
- `d`：删除选中内容。
- `p`：粘贴选中内容。

### 3.6 宏操作

- `q{register}`：开始录制宏，{register} 是一个字母，表示寄存器。
- `{commands}`：执行一系列命令。
- `q`：停止录制宏。
- `@{register}`：执行宏。
- `@@`：重复上一个宏。

### 3.7 多文件操作

- `:e filename`：打开文件 `filename`。
- `:n`：打开下一个文件。
- `:prev` 或 `:N`：打开上一个文件。
- `:bnext` 或 `:bn`：切换到下一个缓冲区。
- `:bprev` 或 `:bp`：切换到上一个缓冲区。
- `:bd`：删除当前缓冲区。

### 3.8 多窗口操作

- `:split filename` 或 `:sp filename`：水平分割窗口并打开文件 `filename`。
- `:vsplit filename` 或 `:vsp filename`：垂直分割窗口并打开文件 `filename`。
- `Ctrl + w, s`：水平分割窗口。
- `Ctrl + w, v`：垂直分割窗口。
- `Ctrl + w, w`：切换到下一个窗口。
- `Ctrl + w, q`：关闭当前窗口。
- `Ctrl + w, =`：使所有窗口大小相等。

## 4. Vim 常用命令

### 4.1 文件和目录操作

```sh
# 打开文件
vim filename

# 查看当前文件路径
:pwd

# 切换到上一个编辑的文件
:e#

# 退出文件并保存
:wq
```

### 4.2 文件系统操作

```sh
# 列出目录内容
:!ls -la

# 创建目录
:!mkdir /path/to/directory

# 删除文件或目录
:!rm -rf /path/to/file_or_directory
```

## 5. 常用操作案例

### 5.1 选择并复制多行

1. 按 `V` 进入行选择模式。
2. 使用 `j` 或 `k` 选择多行。
3. 按 `y` 复制选择的行。

### 5.2 查找并替换

1. 在正常模式下输入 `:%s/old/new/g` 替换整个文件中的 `old` 为 `new`。
2. 输入 `:n` 查找下一个匹配项，输入 `:N` 查找上一个匹配项。

### 5.3 删除多行

1. 按 `V` 进入行选择模式。
2. 使用 `j` 或 `k` 选择多行。
3. 按 `d` 删除选择的行。

### 5.4 使用宏重复操作

1. 按 `qa` 开始录制宏到寄存器 `a`。
2. 执行一系列命令。
3. 按 `q` 停止录制宏。
4. 按 `@a` 执行宏。

## 6. 配置 Vim 适合于 C 及 Python 语言开发的 IDE 环境

### 6.1 创建配置文件

Vim 的配置文件为 **`~/.vimrc`**。你可以使用 Vim 创建和编辑此文件：

```sh
vim ~/.vimrc
```

### 6.2 基本配置

在 **`~/.vimrc`** 中添加以下基本配置：

```vim
" 基本设置
set number              " 显示行号
set tabstop=4           " 设置制表符为 4 个空格
set shiftwidth=4        " 设置自动缩进为 4 个空格
set expandtab           " 将制表符转换为空格
set autoindent          " 自动缩进
set smartindent         " 智能缩进
set cursorline          " 高亮当前行
set wildmenu            " 命令行补全增强
set showcmd             " 显示命令
set clipboard=unnamed   " 使用系统剪贴板
set hlsearch            " 高亮搜索结果
set incsearch           " 增量搜索
set ignorecase          " 搜索时忽略大小写
set smartcase           " 如果包含大写字母则区分大小写
syntax on               " 语法高亮
filetype plugin indent on " 启用文件类型检测、插件和自动缩进
```

### 6.3 安装插件管理器

使用 **vim-plug** 作为插件管理器。在终端中执行以下命令安装 **vim-plug**：

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 6.4 安装 C 及 Python 语言开发相关插件

在 **`~/.vimrc`** 中添加以下内容来

安装 C 及 Python 语言开发相关的插件：

```vim
" 加载插件管理器
call plug#begin('~/.vim/plugged')

" C 及 Python 语言语法高亮和代码补全插件
Plug 'preservim/nerdtree'            " 文件浏览器插件
Plug 'vim-airline/vim-airline'       " 状态栏美化插件
Plug 'vim-airline/vim-airline-themes'" 状态栏主题插件
Plug 'scrooloose/nerdcommenter'      " 代码注释插件
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " 文件搜索插件
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'            " 语法检查和代码补全插件
Plug 'ycm-core/YouCompleteMe'        " 代码补全插件
Plug 'nvie/vim-flake8'               " Python 代码检查插件
Plug 'kien/ctrlp.vim'                " 文件搜索插件
Plug 'honza/vim-snippets'            " 代码片段集合
Plug 'tpope/vim-fugitive'            " Git 集成插件

" 结束插件管理器
call plug#end()

" C 语言开发配置
autocmd FileType c setlocal shiftwidth=4 tabstop=4

" Python 开发配置
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab

" NERDTree 配置
map <C-n> :NERDTreeToggle<CR>

" Airline 配置
let g:airline#extensions#tabline#enabled = 1

" FZF 配置
map <C-p> :Files<CR>

" ALE 配置
let g:ale_linters = {
\   'c': ['gcc'],
\   'python': ['flake8'],
\}

" YouCompleteMe 配置
let g:ycm_global_ycm_extra_conf = expand('~/.vim/.ycm_extra_conf.py')
```

### 6.5 安装插件

在 Vim 中执行以下命令安装插件：

```sh
:PlugInstall
```

### 6.6 配置代码补全插件

**YouCompleteMe** 需要进行额外配置。首先，安装 **YouCompleteMe** 的依赖：

在 **CentOS** 上：

```sh
sudo dnf install -y cmake gcc-c++ make python3-devel
```

在 **Ubuntu** 上：

```sh
sudo apt install -y cmake g++ make python3-dev
```

在 **MacOS** 上：

```sh
brew install cmake python
```

然后，编译 **YouCompleteMe** 插件：

```sh
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all
```

### 6.7 创建 .ycm_extra_conf.py 文件

在你的项目根目录下创建 **`~/.vim/.ycm_extra_conf.py`** 文件，内容如下：

```python
import os
import ycm_core

flags = [
  '-Wall',
  '-Wextra',
  '-Werror',
  '-std=c++17',
  '-x',
  'c++',
  '-I',
  '.',
]

c_flags = [
  '-Wall',
  '-Wextra',
  '-Werror',
  '-std=c11',
  '-x',
  'c',
  '-I',
  '.',
]

python_flags = [
  '-Wall',
  '-Wextra',
  '-Werror',
  '-x',
  'python',
  '-I',
  '.',
]

go_flags = [
  '-Wall',
  '-Wextra',
  '-Werror',
  '-x',
  'go',
  '-I',
  '.',
]

def Settings(**kwargs):
  language = kwargs['language']
  if language == 'cfamily':
    return {
      'flags': flags
    }
  elif language == 'python':
    return {
      'flags': python_flags
    }
  elif language == 'go':
    return {
      'flags': go_flags
    }
  return {}
```

### 6.8 配置 Python 环境

在 **`~/.vimrc`** 中添加以下内容来配置 Python 开发环境：

```vim
" 设置 Python 3 解释器路径
let g:python3_host_prog = '/usr/bin/python3'

" 启用 flake8 进行 Python 代码检查
let g:ale_linters = {
\   'python': ['flake8'],
\}
```

### 6.9 测试配置

现在，你可以打开一个 C 或 Python 语言文件，测试你的 Vim IDE 环境。以下是一些常用的快捷键和命令：

- `Ctrl + n`：打开或关闭 NERDTree 文件浏览器。
- `:w`：保存文件。
- `:q`：退出 Vim。
- `:wq`：保存并退出 Vim。
- `gcc`：注释或取消注释当前行（需要安装 NERDCommenter 插件）。

## 7. 总结

在这篇扩展阅读文章中，我们介绍了 Vim 的基本使用和常见配置，并展示了 Vim 的常用快捷键和多文件、多窗口操作。最后，我们配置出了一款适合于 C 及 Python 语言开发的 IDE 环境。通过掌握这些内容，你可以更高效地使用 Vim 进行代码编写和编辑。
