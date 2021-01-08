#!/usr/bin/awk -f
# colcheck.awk - 检验每列数据类型是数字还是字符串类型
#   输入： 数字或者字符串
#   输出： 不符合第一行格式类型的行数据

NR==1{
	nfld = NF
	for(i=1; i<= NF; i++)
		type[i] = isnum($i)
} {
	if(NF != nfld)
		printf("第 %d 行有 %d 列数据而不是 %d 列\n", NR, NF, nfld)
	for(i=1;i<=NF;i++)
		if(isnum($i) != type[i])
			printf("第 %d 行的第 %d 列值为: %s ,与第一行类型不符合\n", NR, i, $i)
}
function isnum(n){ return n~/^[+-]?[0-9]+$/}
