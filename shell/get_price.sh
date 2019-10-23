#!/bin/bash
#########################################################################
# File Name: get_price.sh
# Author: zwker
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年10月23日 星期三 11时32分36秒
# Note: 此脚本为批量抓取网页中的价格数据示例，不一定适用于所有网页哦
#########################################################################

#url="http://www.zhujiage.com.cn/article/201910/1024574_3.html"

tmpfile=/tmp/tmp.`basename $0`.txt

usage()
{
cat <<END
Usage:
	`basename $0`  <url-prefix>  <page-num>
	url-prefix	:  页面的网络地址前缀,例如 "http://www.zhujiage.com.cn/article/201910/1024574_3.html" 的前缀是 "http://www.zhujiage.com.cn/article/201910/1024574"
	page-num    :  分页数量,会根据这个分页数量拼接页面地址进行访问。
END
}

get_data()
{
	curl ${1} | iconv -f gbk -t utf-8 | awk -F ">" '/价格 ..?月..?日/ && $0~/^<p style/{print $2}' | sed 's/<.*//g' | awk 'NF==7'
}


main()
{
	## 默认为10月23日生猪价格页面 #
	pre=${1:-"http://www.zhujiage.com.cn/article/201910/1024574"}
	pagenum=${2}
	url="${pre}.html"

	get_data ${url}
	for i in `seq 2 ${pagenum}`
	do
		url="${pre}_$i.html"
		echo "${url}"  1>&2
		get_data ${url}
	done
}

################  开始 main  ######

if [ "$#" != "2" ] ; then
	usage
	exit -1
fi

main $@  > ${tmpfile}

[[ "$?" == "0" ]] && awk '{ idx=$3"_"$4"_"$1 "," $5 ; sum[idx]+= $6; cnt[idx]++ }END{ for( i in sum) printf("%s,%.02f\n", i , sum[i]/cnt[i] )}' ${tmpfile} | column -t|sort | r2c r 3

[[ "$?" == "0" ]] && rm -f ${tmpfile}


