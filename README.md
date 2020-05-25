<div align="center">
  <img width="500px" src="https://github.com/yuanming-hu/taichi/raw/master/misc/logo.png">
  <h3> <a href="https://github.com/taichi-dev/taichi"> 项目仓库 </a> | <a href="https://taichi.readthedocs.io/zh_CN/latest/"> 中文文档 </a> | <a href="https://taichi.readthedocs.io/zh_CN/latest/hello.html"> 教程 </a> | <a href="https://github.com/yuanming-hu/taichi/tree/master/examples"> 示例 </a> | <a href="https://taichi.readthedocs.io/en/latest/contributor_guide.html"> 参与开发 </a> | <a href="https://forum.taichi.graphics/"> 论坛 </a> </h3>
</div>

----------

# Taichi 官方中文文档

[预览地址](https://taichi.readthedocs.io/zh_CN/latest/)

[Taichi](https://github.com/taichi-dev/taichi) 是一门高效的、以 Python 语法封装的计算机图形应用语言。这里是 Taichi 的中文文档。

|         | readthedocs.io | GitHub Actions |
| ------- | -------------- | -------------- |
| latest  | [![构建状态](https://readthedocs.org/projects/taichi-zh/badge/?version=latest)](https://taichi.readthedocs.io/zh_CN/latest/?badge=latest) | ![提交检查](https://img.shields.io/github/workflow/status/taichi-dev/taichi-docs-zh-cn/提交检查) |

## 鸣谢

Taichi 简体中文文档由 [Ark (StephenArk30)](https://github.com/StephenArk30) 创立，至今做出重大贡献者有：
  - [彭于斌 (archibate)](https://github.com/archibate)
  - [Danni (isdanni)](https://github.com/isdanni)
  - [Chengchen Wang (rexwangcc)](https://github.com/rexwangcc)
  - [万健洲 (ArkhamWJZ)](https://github.com/ArkhamWJZ)

[[全部贡献者列表]](https://github.com/taichi-dev/taichi-docs-zh-cn/graphs/contributors)

Taichi 及其中文文档能够如此快速地成长，离不开你们的热心贡献和付出，感谢大家！

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

1. 在控制台（powershell 可能会有一些问题，如果你是 windows 可以使用 cmd）执行下列命令:

   ```bash
   git clone https://github.com/你的用户名/taichi-docs-zh-cn.git --depth=1
   cd taichi-docs-zh-cn
   git remote add upstream https://github.com/taichi-dev/taichi-docs-zh-cn.git
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

**关于翻译的一些规则请看 [Wiki](https://github.com/taichi-dev/taichi-docs-zh-cn/wiki)。**

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

# 如何更新旧翻译？

翻译全被认领了？没关系！你还可以帮我们**更新**旧的翻译。

带有 [needs update 标签](https://github.com/taichi-dev/taichi-docs-zh-cn/issues?q=is%3Aissue+is%3Aopen+label%3A%22needs+update%22)的 Issue 是需要更新的翻译。
比如 `[翻译需要更新] hello`，要认领的话，就另外新建一个 Issue，标题为: `[翻译中] hello`。告诉大家你已经在更新这个翻译了。管理员会关闭之前那个 `[翻译需要更新] hello` 的 Issue。

## 开始翻译！

同样是使用 poedit 打开相应的 .po 文件：

```bash
poedit locales/zh_CN/LC_MESSAGES/hello.po
```

你会看到其中几行显示为橘黄色字体，那些就是原文档更新需要变动的部分了。

## 我们还提供了一些小工具...

Taichi 的原文档更新了之后，我们也需要更新相应的中文文档。要想知道哪些部分更新了，可以输入下面的命令：

```bash
make fuzzy
```

你会看到几行 .po 文件名，这些就是原文档更新之后存在差异的文件。在有差异的字符串前会有 `#, fuzzy` 的注释。

---

要想知道还有哪些文件没翻译（包括最近更新的，和原来没翻译的）:

```bash
make todo
```

不过这两个命令暂时只支持 *nix 平台。
