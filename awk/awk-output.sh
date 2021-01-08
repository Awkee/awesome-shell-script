#!/bin/bash
#########################################################################
# File Name: awk-output.sh
# Author: zioer
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年09月12日 星期四 14时11分10秒
#########################################################################

# 1. print 使用

### 1.0 准备数据 ###
cat <<END
1 2 3
2 5 6
9 1 10
3 97 1
6 1 5
END

### 1.1 简单print 使用示例 ###
awk '$1 >0'
awk '{ print $0 }' 
awk '{ print $1,$2,$3 }'

awk '{ print $1,$2,$3 > "test.txt" }'
awk '{ print $1,$2,$3 >> "test.txt" }'

### 1.2重定向输出结果到标准错误 ###

awk '{ print $1,$2,$3 > "/dev/stderr" }'

awk '{ print $1,$2,$3 | "cat 1>&2" }'

awk '{ msg=$1 " " $2 " " $3 ; system("echo '\''" msg "'\'' 1>&2") }'


### 1.3 对输出结果进行管道处理 #
awk '{ print $1,$2,$3 | "sort" }'



### 1.4 关闭和管道的方法 ###

# close(expr) 可以关闭打开的文件或者管道命令 ### 保证close方法参数文件名或者管道命令相同就可以关闭 #
awk '{ print $-1 >> "test.txt" }END{ close( "test.txt") }'
awk '{ print $0 | "sort -nrk1" }END{ close( "sort -nrk1") }'

## 思考：为什么要关闭文件呢？ 









