#!/bin/bash
#########################################################################
# File Name: info.sh
# Author: zwker
# mail: xiaoyu0720@gmail.com
# Created Time: 2019年10月11日 星期五 10时06分21秒
#########################################################################

awk '
BEGIN{ FS="\t"}
$1~/'$1'/{
	printf("%s:\n", $1)
	printf("\t%d million people\n", $3)
	printf("\t%.3f million sq.mi.\n",$3/1000)
	printf("\t%.1fpeople per sq.mi.\n", 1000*$3/$2)
}' countries
