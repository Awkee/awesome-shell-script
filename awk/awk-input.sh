#!/bin/bash
#########################################################################
# File Name: awk-input.sh
# Author: zioer
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年09月14日 星期六 13时10分14秒
#########################################################################

cat <<END > data.txt
1  2  3
4   5 6
7 8     9
END

cp data.txt f1
cp f1 f2

awk 'BEGIN{ print "RS和FS自定义设置示例:"; FS="\n"; RS=" "; }{ print $1,NF }' data.txt

awk 'BEGIN{ print "RS和FS自定义设置示例:"; FS="\n"; RS="[ \t]+"; }{ print $1,NF }' data.txt


./diff.awk f1 f2 

./seq.awk 1 100 9


