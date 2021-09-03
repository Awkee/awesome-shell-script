# awesome-shell-script
汇总自己写过的shell脚本工具


- awk脚本合集
- dotfiles配置
- Shell脚本工具

## Awk脚本合集

Awk目录下保存了很多的Awk脚本工具，如果你想学习Awk脚本编程，这将会是非常有帮助的。


## dotfiles配置文件分享

- tmux.conf 终端多分器工具配置文件, tmux工具配置文件，支持插件管理，会话自动保存功能，即使退出了tmux服务，下次再运行时环境跟上次退出前一致。
- vimrc Vim编辑器配置文件
- zshrc Zsh配置文件


## Shell脚本工具

### useproxy-在你想使用代理时使用它
> 执行命令时希望使用代理怎么办？ 使用useproxy脚本就可以了。

有时候，git 命令 或者 wget 命令需要使用代理下载数据时怎么办？安装个 proxychains4 工具？没必要，写个脚本就够用了。看看怎么用吧:
```bash
$ useproxy git pull
....

$ useproxy youtube-dl xxxxxx
...

$ useproxy wget -c https://xxxx...

```
默认使用代理地址为`socks5://127.0.0.1:1080` , 可以自定义么？当然！

```bash
# -s 使用 HTTP协议代理类型: http://192.168.1.1:8080
$ useproxy -s -p 8080 -l 192.168.1.1 wget -c http://xxxx
...

# 通过代理服务器进行DNS解析(某些网站本地DNS污染了)
$ useproxy -d  wget -c https://yt.be.xxxxx
...

```

简单的命令脚本，看看内部只使用了`HTTP_PROXY`和`HTTPS_PROXY`环境变量。

#### alias别名方法
> 也许，你连脚本也不想添加，那添加一个alias别名命令如何呢？

如果你使用Bash，就在`$HOME/.bashrc`里加入如下命令，zsh可以在`$HOME/.zshrc`里添加:
```bash
alias useproxy='HTTP_PROXY=socks5://127.0.0.1:1080  HTTPS_PROXY=socks5://127.0.0.1:1080'
```
来看看使用方法,跟上面的方法一样：
```bash
# 执行示例
$ useproxy curl https://httpbin.org/ip
...

```

当然这很简单，非常适合长期使用一个固定代理端口的人使用，这么多方法，选择你自己的方法吧。


### cellid
>一个用来查询基站位置信息的脚本工具

### r2c
>一个用于将行数据转置为行列数据合并展示，行列位置可选

### tsk.dcc
> tshark 命令分析DCC消息的脚本工具。

### 163.py 音乐下载工具

查看帮助信息: `163.py -h`
使用方法： `163.py https://music.163.com/playlist?id=123456789'



