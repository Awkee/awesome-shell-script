#!/usr/bin/awk -f
## prbill.awk 
#    input: 流水号\t费用\t付费人
#    output: 费用账单信息

BEGIN{
	FS="\t"
	dashes = sp45 = sprintf("%45s", " ")
	gsub(/ /,"-",dashes)
	"date"|getline date
	split(date, d, " ")
	date = d[2] " " d[3] "," d[5]
	initnum()
}
NF != 3 {
	printf("\nline %d illegal:\n%s\n\nVOID\nVOID\n\n\n",NR,$0)
	next
}
{
	printf("\n")
	printf("%s%s\n", sp45, $1)
	printf("%s%s\n", sp45, date)
	amt = sprintf("%.2f", $2)
	printf("付费给 %45.45s   ￥%s\n",$3 dashes, amt)
	printf("总计 %s\n", numtowords(amt))
	printf("\n\n\n")
}
function numtowords(n, money, jiao, yuan, res){
	split(n, money, ".")
	jiao = money[2] + 0
	yuan = money[1] + 0
	res = ""
	if(jiao == 0)
		res = "整"
	else if(jiao %10 == 0)
		res = nums[int(jiao/10)] "角"
	else if(int(jiao/10) == 0)
		res = nums[jiao%10] "分"
	else
		res = nums[int(jiao/10)] "角" nums[jiao%10] "分"
	return intowords(yuan) "元" res
}
function intowords(n, res) {
	n = int(n)
	res = ""
	for( idx = 0 ; n > 0 ; idx ++ ) {
		tmp = n % 10
		if( tmp != 0 )
			res = nums[tmp] tens[idx] res
		n = int(n/10)
		if(tmp == 0 && n%10 != 0 )
			res = nums[10] res
		if( tmp == 0 && (idx == 4 || idx == 8) )
			res = tens[idx] res
	}
	return res
}
function initnum(){
	split("壹 贰 叁 肆 伍 陆 柒 捌 玖 零", nums, " ")
	split("拾 佰 仟 万 拾 佰 仟 亿 拾 佰 仟" , tens, " ")
}

