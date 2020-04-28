<div align="center">
  <img width="500px" src="https://github.com/yuanming-hu/taichi/raw/master/misc/logo.png">
  <h3> <a href="https://github.com/taichi-dev/taichi"> 项目仓库 </a> | <a href="https://taichi.readthedocs.io/zh_CN/latest/"> 中文文档 </a> | <a href="https://taichi.readthedocs.io/zh_CN/latest/hello.html"> 教程 </a> | <a href="https://github.com/yuanming-hu/taichi/tree/master/examples"> 范例 </a> | <a href="https://taichi.readthedocs.io/en/latest/contributor_guide.html"> 参与开发 </a> | <a href="https://forum.taichi.graphics/"> 论坛 </a> </h3>
</div>

----------

# Taichi 官方中文文档

预览地址: https://taichi-zh.readthedocs.io/zh_CN/latest/

| Version | Document Status                                              |
| ------- | ------------------------------------------------------------ |
| latest  | [![Documentation Status](https://readthedocs.org/projects/taichi-docs-zh-cn/badge/?version=latest)](https://taichi-zh.readthedocs.io/zh_CN/latest/?badge=latest) |

[Taichi](https://github.com/taichi-dev/taichi) 是一门高效的、以 Python 语法封装的计算机图形应用语言。这里是 Taichi 的中文文档。

----------

# 我如何参与翻译？

## 如果你是第一次

1. 准备下列工具:

  - Git
  
  - GitHub 账号
  
  - Python 3
  
  - 一个 PO 编辑器，推荐 [poedit](https://poedit.net/)
  
  - (如果你是 MacOS) 请安装 gettext:
  
    ```bash
    brew install gettext
    brew link gettext --force
    ```

1. Fork 本仓库（点击右上角的 Fork 按钮）。

1. 在控制台执行下列命令:

   ```bash
   git clone https://github.com/你的用户名/taichi-docs-zh-cn.git --depth=1
   cd taichi-docs-zh-cn
   git remote add upstream https://github.com/StephenArk30/taichi-docs-zh-cn.git
   git submodule update --depth=1
   make all
   ```

## 翻译前的准备

1. 假如你要翻译的文件是 hello.rst。

1. 在 [Issue 页面](https://github.com/taichi-dev/taichi-docs-zh-cn/issues) 点击 `New Issue`，新建一个 Issue，标题为: `[翻译中] hello`，这是告诉大家你已经在翻译这个文件了，避免重复劳动。当然，也要注意一下是不是已经有人在翻译中了。

1. 在每一次准备开始新的翻译时:

   ```bash
   git fetch upstream
   make merge
   git checkout -b hello upstream/master
   ```
   （这里 hello 也可以是任何名字，用**待翻译的文件名**来命名就是不错的选择）

## 开始翻译！

可以看到 `locales/zh_CN/LC_MESSAGES` 文件夹中有很多 .po 文件，这些就是我们要翻译的了。现在用你的 PO 编辑器编辑它们:

   ```bash
   poedit locales/zh_CN/LC_MESSAGES/hello.po
   ```

**注意: 翻译时我们只修改 .po 文件，不修改其它的任何文件，比如 .rst。**

**关于翻译的一些规则请看 [Wiki](https://github.com/StephenArk30/taichi-docs-zh-cn/wiki)。**

关于 .po 文件的更多信息，可以查阅 [gettext wiki](https://en.wikipedia.org/wiki/Gettext) 和 [gettext manual](http://www.gnu.org/software/gettext/manual/gettext.html)。

翻译完成后，执行：

   ```bash
   make html
   ```

这会新建一个 build 文件夹，里面存放生成的网页文件。
现在请用浏览器打开 `build/html/index.html`，找到你翻译的那个章节，看一下效果。

## 提交合并请求

如果翻译没问题，就可以push到你的fork仓库了：

```bash
git add locales
git commit -m "[翻译完毕] hello"
git push origin HEAD
```

接着，前往 [Pull requests 页面](https://github.com/taichi-dev/taichi-docs-zh-cn/pulls)。你应该会看到一个黄色的框框，点击其中的 Compare & pull request 按钮。
填写说明，点击 Create pull request 按钮，这样就发起合并请求了。
稍后管理员会审核您的翻译，如果没问题，就会合并进本仓库。

Pull request 的详细操作方法可以参考：[Pull Request 的命令行管理](http://www.ruanyifeng.com/blog/2017/07/pull_request.html)。

## 我们还提供了一些便利的工具...

Taichi 原文档更新之后，要想知道哪些部分更新了，可以输入下面的命令：

```bash
make fuzzy
```

你应该会看到几行 .po 文件名，这些就是原文档更新之后存在差异的文件。在有差异的字符串前会有`#, fuzzy`的注释。
