<div align="center">
  <img width="500px" src="https://github.com/yuanming-hu/taichi/raw/master/misc/logo.png">
  <h3> <a href="https://taichi.readthedocs.io/en/latest/"> Docs </a> | <a href="https://taichi.readthedocs.io/en/latest/hello.html"> Tutorial </a> | <a href="https://github.com/yuanming-hu/difftaichi"> DiffTaichi </a> | <a href="https://github.com/yuanming-hu/taichi/tree/master/examples"> Examples </a> | <a href="https://taichi.readthedocs.io/en/latest/contributor_guide.html"> Contribute </a> | <a href="https://forum.taichi.graphics/"> Forum </a> </h3>
</div>

----------

# Taichi中文文档

| Version | Document Status                                              |
| ------- | ------------------------------------------------------------ |
| latest  | [![Documentation Status](https://readthedocs.org/projects/taichi-docs-zh-cn/badge/?version=latest)](https://taichi-docs-zh-cn.readthedocs.io/zh_CN/latest/?badge=latest) |

Taichi: https://github.com/taichi-dev/taichi

Taichi是一门高效的、以python语法封装的计算机图形应用语言。这里是Taichi documentation的中文翻译版本。

# 翻译流程

## 事先准备

- git

- github账号

- python3

- 一个.po编辑器，推荐[poedit](https://poedit.net/)

- MacOS 需要安装 gettext :

  ```bash
  brew install gettext
  brew link gettext --force
  ```

## 准备仓库

1. 在本仓库新建一个叫“[翻译中]hello(这个是你要翻译的文件名)”的[issue](https://github.com/StephenArk30/taichi-docs-zh-cn/issues)，告诉大家你已经在翻译这个文件了。当然，翻译之前也要看看这个文件是否已经在翻译了。

2. fork本仓库（点击右上角Fork）。

3. clone你fork的仓库，注意是你的仓库不是这个原仓库：

   ```bash
   git clone https://github.com/{YOUR USERNAME}/taichi-docs-zh-cn.git
   ```

4. 打开控制台，进入仓库文件夹：

   ```bash
   cd path/to/taichi-docs-zh-cn
   ```

5. 设置本仓库为upstream上游地址，以和本仓库进行同步：

   ```bash
   git remote add upstream https://github.com/StephenArk30/taichi-docs-zh-cn.git
   ```

6. 在**每一次**准备开始新的翻译时，同步上游仓库：

   ```bash
   git fetch upstream
   ```

7. 新建一个分支，分支名为你要翻译的文件，例如要翻译hello：

   ```bash
   git checkout -b hello upstream/master
   ```

8. 在**第一次**clone仓库后，需要执行：

   ```bash
   make
   ```

   这会帮助你自动搭建venv环境和clone taichi原仓库到tmp文件夹下。

9. 在之后**每一次**翻译之前，最好执行：

   ```bash
   make merge
   ```

   这会帮你自动同步taichi原英文文档并更新.po文件。我们的翻译文档最好与最新的英文文档保持一致。

## 开始翻译

现在，你可以看到./locales/zh_cn/LC_MESSAGES文件夹中的.po文件，这些就是我们需要翻译的文件了。你可以用poedit打开进行编辑。注意，我们只修改po文件，不修改其它的.rst。

关于.po文件，可以查阅[gettext wiki](https://en.wikipedia.org/wiki/Gettext)和[gettext manual](http://www.gnu.org/software/gettext/manual/gettext.html)。

**翻译前请查看本仓库[wiki](https://github.com/StephenArk30/taichi-docs-zh-cn/wiki)。**

如果英文文档更新之后要翻译**更新的部分**，可以输入下面的命令：

```bash
make fuzzy
```

你或许会看到几行.po文件名，这些就是英文文档更新之后存在差异的文件。在有差异的字符串前会有`#, fuzzy`的注释。

在翻译完成后，要执行：

```bash
make html
```

这步操作会在文件夹下新建build文件夹，里面存放生成的网页文件。打开build/html/index.html，找到你翻译的那个章节查看一下效果。

## 合并到本仓库

如果翻译没问题，就可以push到你的fork仓库了：

```bash
git add hello.po
git commit -m "hello.po translated."
git push origin HEAD
```

接着，到你的github仓库点击pull request，new pull request，填写说明，create pull request。这样就可以发起合并请求了。具体可以参考：[Pull Request 的命令行管理](http://www.ruanyifeng.com/blog/2017/07/pull_request.html)。
