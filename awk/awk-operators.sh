#!/bin/bash
#########################################################################
# File Name: awk-operators.sh
# Author: zioer
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年09月10日 星期二 13时26分13秒
#########################################################################

## 1. 下面的命令有什么不同?

## 1. what's difference about these commands 
cat <<END > data.txt
-1
END

# what's the output ?
awk '$1 < 0 { print "abs($1) = " - $1}'  data.txt
awk '$1 < 0 { print "abs($1) = " (-$1) }'  data.txt
awk '$1 < 0 { print "abs($1) = " ,-$1 }'  data.txt



## 函数定义，注意函数内部的变量的生命周期 ##
awk 'function maxa(m, n){
  maxn = m > n ? m : n;
    return maxn;
}
function maxb(m, n, maxm){
  maxm = m > n ? m : n;
    return maxm;
}
{
    print maxa($1,$2), maxn;
    print maxb($1,$2), maxm;
}'



### ------END -----

