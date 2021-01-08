#!/usr/bin/awk -f
function isprime(n, i){
	for(i=2; i <= sqrt(n) ;i++) {
		if( n % i == 0) return 0
	}
	return 1
}
function isprime2(n, i){
	for(i=2; i <= n-1 ;i++) {
		if( n % i == 0) return 0
	}
	return 1
}
function initprime(n , i, j){
	for(i=2; i <= sqrt(n) ;i++) {
		for(j = i+i; j <= n;j+=i){
			pr[j] = 1
		}
	}
}
function isprime3(n) {
	if( n in pr ) return 1
	return 0
}
NF==1&& $1~/^[0-9]+$/{
	max=$1
	len = length(max"")
	fmt = "%"len"d%s"
	if( max == "")
		max = 100
	printf(fmt, 2 , " ");
	idx = 1
	for( i = 3; i <= max; i+=2) {
		if( isprime(i) ) 
			printf(fmt, i, (++idx)%10 == 0 ? "\n": " ")
	}
	printf("\ntotal prime number: %d , percent: %4.2f%%\n", idx , idx/max*100)
}
