#!/usr/bin/awk -f

NR != 1 && NF == 3{
	area[$1]++
	industry[$2]++
	list_date[substr($3,1,4)]++
}
NF!=3{ print $0 > "/dev/stderr" }
END{
	printf("%-15s %10s\n","地区","公司数")
	for(i in area) { printf("%-15s %10d\n", i, area[i])| "sort -nk2"}
	close("sort -nk2")
	printf("==========  ====\n")

	printf("%-15s %10s\n","行业","公司数")
	for(i in industry) { printf("%-15s %10d\n", i, industry[i]) |"sort -nk2"}
	close("sort -nk2")
	printf("==========  ====\n")

	printf("%-15s %10s\n","上市年份","公司数")
	for(i in list_date) { printf("%-15s %10d\n", i, list_date[i]) |"sort"}
	close("sort")
	printf("==========  ====\n") 
} 
