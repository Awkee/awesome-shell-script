#!/usr/bin/awk -f

function prinfo(i){
	for(i = 1; i <= NF; i++)
		f($i)
	for(i = 1; i<=len; i++)
		printf("%s ", res[idx[i]] )
	print ""
}
function f(n){
	split(n, arr, " ")
	return res[arr[1]] = arr[2]
}
BEGIN{ FS="\n"; RS = "";len=split("姓名 年龄 身高 地址", idx, " ");}
{ prinfo() }

