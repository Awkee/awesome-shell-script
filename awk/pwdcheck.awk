#!/usr/bin/awk -f
# pwdcheck.awk 检查passwd文件
BEGIN{ FS=":"}
NF != 7{ printf("第%d行不是7列数据:%s\n",NR,$0)}
$1~/[^a-z0-9]/{ printf("第%d行用户名不是字母或数字组合:%s\n",NR,$0)}
$2 == ""{ printf("第%d行用户密码为空:%s\n",NR,$0)}
$3 ~/[^0-9]/{ printf("第%d行用户ID非数字:%s\n",NR,$0)}
$4 ~/[^0-9]/{ printf("第%d行组ID非数字:%s\n",NR,$0)}
$6 !~/^\//{ printf("第%d行用户HOME目录不是绝对路径:%s\n",NR,$0)}

