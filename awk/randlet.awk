#!/bin/awk -f

## randint - 生成随机数x，其中 1 <= x <= n
function randint(n) {
        return int(n * rand()) + 1
}
function randletter() {
        return substr("abcdefghijklmnopqrstuvwxyz", randint(26), 1)
}
BEGIN{
	"echo $RANDOM"| getline sr
	srand()
	n = srand(sr)
	print "n="n "," randletter()
}
