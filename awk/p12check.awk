#!/usr/bin/awk -f
# p12check.awk 定界符有效性检验
# 检验Awk的语句块{}定界符有效性
/{/{ 
	srow[p++] = NR
}
/}/{
	if( p == 0 ) 
		printf("语法错误:第%d行前缺少了{\n", NR)
	else
		erow[p--] = NR
}
END{
	if( p != 0)
		printf("语法错误:第%d行的}之后缺少与第%d行的{匹配\n", erow[p+1] , srow[p])
}



