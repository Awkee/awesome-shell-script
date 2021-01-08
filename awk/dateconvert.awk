#!/usr/bin/awk -f
# 日期格式转换: 将第一列转换 mmddyy ==> yymmdd 
{
	$1=substr($1,5,2) substr($1,1,2) substr($1,3,2) 
	print
}
