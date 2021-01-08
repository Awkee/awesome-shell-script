#!/usr/bin/awk -f
# insertion sort
BEGIN{
	print "排序："
	print "输入示例：   8 1 6 3 5 2 4 7"
}
{ 
	for( i = 1; i <= NF; i++) 
		A[i] = $i ; 
	# isort(A, NF) 
	hsort(A, NF) 
	#qsort(A, 1, NF) 
	## 显示结果
	show(A,1,NF)
	nl()
}
function show(arr,start ,end , j, i) {
	for( i = start ; i < end ; i++)
		printf("%d%s", arr[i], i == j ? "|":" ")
	printf("%d%s\n", arr[i], i == j ? "|":"")
}
function show2(arr,start ,end , j, i) {
	for( i = start ; i < end ; i++)
		printf("%s%d%s", i == j ? "|":" " , arr[i], i == j ? "|":" ")
	printf("%s%d%s\n", i==j?"|":"", arr[i], i == j ? "|":"")
}
function nl() {
	printf("---------------------------------\n")
}
## insertion sort
function isort( arr, n, i, j,t) {
	for( i = 2; i <= n; i++) {
		for( j = i ; j > 1 && arr[j-1] > arr[j] ; j--){
			swap(arr, j-1, j)
		}
		show(arr, 1, n, i)
	}
	nl()
}
## quick sort
function qsort(A, left, right, i, last){
	srand()
	if( left >= right)
		return
	## 随机选择 last 中间数
	swap(A,left,left + int((right-left+1) * rand()))
	## 以last为中心划分左侧和右侧两部分
	last = left
	for(i = left+1; i <= right; i++)
		if( A[i] < A[left])
			swap(A, ++last, i)
	swap(A,left,last)
	show2(A,left,right,last)

	## 递归继续排序左侧和右侧两部分
	qsort(A,left, last-1)
	qsort(A,last+1, right)

}
## heap sort
function hsort(A, n, i){
	# 建堆
	for( i = int(n/2); i >= 1; i--) {
		heapify(A, i, n)
	}
	show(A, 1,n)
	# 挑出最大数后重新建堆 #
	for( i = n; i > 1 ; i--) {
		swap(A, 1, i)
		heapify(A, 1, i-1)
		show(A, 1,n, i)
	}
}
function heapify(A, left, right,  p,c) {
	for( p = left; (c = 2*p) <= right; p = c){
		if( c < right && A[c+1] > A[c])
			c++
		if( A[p] < A[c])
			swap(A, c, p)
	}
}


function test(sort, data,n) {
	comp = exch = 0
	if( data ~/rand/)
		genrand(A,n)
	else if( data ~/id/)
		genid(A,n)
	else if( data ~/rev/)
		genrev(A,n)
	else
		print "illegal type of data in ", $0
	if( sort ~/q.*sort/)
		qsort(A,1,n)
	else if( sort ~/h.*sort/)
		hsort(A,n)
	else if( sort ~/i.*sort/)
		isort(A,n)
	else 
		print "illegal type of sort in ",$0
	print sort,data, n, comp exch, comp+exch
}

function check(A,n,i) {
	for(i = 1; i<n;j++)
		if(A[i] > A[i+1])
			printf("array is not sorted, element %d\n",i)
}
function genrand(A,n,i) {
	srand()
	for(i=1;i<=n;i++)
		A[i] = int(n*rand())
}
function gensort(A,n,i,x) {
	srand()
	x = int(n*rand())
	for(i=1;i<=n;i++)
		A[i] = i+x
}
function genrev(A,n,i,x){
	srand()
	x = int(n*rand())
	for(i=1;i<=n;i++)
		A[i] = n+x
}
function genid(A,n,i){
	for(i=1;i<=n;i++)
		A[i] = 1
}
function swap(A,i,j, t){
	t = A[i]; A[i] = A[j]; A[j] = t
}
