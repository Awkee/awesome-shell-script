# awesome-shell-script
汇总自己写过的shell脚本工具

# 工具集合

## cellid
>一个用来查询基站位置信息的脚本工具

## r2c
>一个用于将行数据转置为行列数据合并展示，行列位置可选

## autoss.py
>自己临时备用的shadowsocks代理脚本.

## tsk.dcc
> tshark 命令分析DCC消息的脚本工具。

# autoss.py 如何在raspberry pi 中使用
> 树梅派raspberrypi(系统:RASPBIAN STRETCH LITE )安装shadowsocks环境

## 1.安装shadowsocks命令工具 sslocal

apt-get install shadowsocks

## 3.安装配置二维码扫描工具

apt-get install -y python-qrtools python-zbar python-wget

wget -O awesome-shell-script.zip https://github.com/Awkee/awesome-shell-script/archive/master.zip
unzip awesome-shell-script.zip
mv awesome-shell-script-master/shell/ ~/bin

echo 'export PATH="$PATH:~/bin:."' >> ~/.bashrc
export PATH="$PATH:~/bin:."


## 4. 使用autoss.py 命令启动代理服务

查看帮助信息: `autoss.py -h`

直接启动: `autoss.py`

重启ss服务: `autoss.py -d restart`

指定shadowsocks二维码URL地址并重启方法: `autoss.py  -d restart http://xxxx/qr/abc.png`
