# awesome-shell-script
汇总自己写过的shell脚本工具

# 工具集合

## cellid
>一个用来查询基站位置信息的脚本工具

## r2c
>一个用于将行数据转置为行列数据合并展示，行列位置可选

## autoss.py
>shadowsocks自动配置脚本，可以使用二维码URL地址也可以识别ss-uri地址作为参数解析

## autossr.py
> shadowsocksR自动配置脚本，可以使用二维码URL地址也可以识别ssr-uri地址作为参数解析

使用方法:
结合 ssr脚本使用 

## tsk.dcc
> tshark 命令分析DCC消息的脚本工具。

# autoss.py 如何在raspberry pi 中使用
> 树梅派raspberrypi(系统:RASPBIAN STRETCH LITE )安装shadowsocks环境

## 1.安装shadowsocks命令工具 sslocal

```
apt-get install shadowsocks
```

## 3.安装配置二维码扫描工具

```
apt-get install -y python-qrtools python-zbar python-wget

wget -O awesome-shell-script.zip https://github.com/Awkee/awesome-shell-script/archive/master.zip
unzip awesome-shell-script.zip
mv awesome-shell-script-master/shell/ ~/bin

echo 'export PATH="$PATH:~/bin:."' >> ~/.bashrc
```


## 4. 使用autoss.py 命令启动代理服务

查看帮助信息: `autoss.py -h`

直接启动: `autoss.py`

重启ss服务: `autoss.py -d restart`

指定shadowsocks二维码URL地址并重启方法: `autoss.py  -d restart http://xxxx/qr/abc.png`

## 5. 增加 163.py Python3编写的工具下载 音乐文件

查看帮助信息: `163.py -h`
使用方法： `163.py https://music.163.com/playlist?id=123456789'

## 6. 增加提取猪肉价格脚本示例工具 get_price.sh

查看帮助信息: `get_price.sh`
使用方法： `get_price.sh http://www.zhujiage.com.cn/article/201910/1024265 11`



