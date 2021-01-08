#!/usr/bin/awk -f
BEGIN{
	FS="\n"
	RS=""
}
{ 
	printf("姓名：%-10s ,年龄: %5d ,身高: %5d ,地址: %s\n", $1, $2, $3, $4)
}
