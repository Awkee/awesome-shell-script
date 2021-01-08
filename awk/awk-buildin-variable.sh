#!/bin/bash
#########################################################################
# File Name: awk-buildin-variable.sh
# Author: zioer
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年09月10日 星期二 11时29分19秒
#########################################################################

## awk 命令的内建变量示例脚本 


# 1.ARGC , ARGV 的使用，通常使用在-f参数或awk脚本文件时使用
awk -f argv.awk -a argv1 -b argv2 argv.awk 

# output ARGC = 2 , ARGV[0] = [awk] , ARGV[1] = [argv.awk]



# 2. FILENAME 变量的使用

### 按照 总行号:文件名：行号：内容 方式输出 ls.awk 文件内容 
awk 'BEGIN{OFS=":"}{ print NR,FILENAME,FNR,$0 }' ls.awk argv.awk



# 3. 





# --- END 

