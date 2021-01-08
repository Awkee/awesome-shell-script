#!/usr/bin/awk -f
function usage(){
    printf("Usage: join.awk [align=right|left] file1 file2 , default left join\n");
}
BEGIN{
    OFS="\t"
	## 参数解析 ##
	if( ARGC >= 3) {
		if( ARGV[1] ~/^align=/) {
			align = substr(ARGV[1],7);
			file1 = ARGV[2]
			file2 = ARGV[3]
		}else {
			align = "left"
			file1 = ARGV[1]
			file2 = ARGV[2]
		}
		#print ARGV[0]","file1 "," file2 "," align ","
	} else {
		usage()
		exit 2
	}
	getgroup( file1, arr1)
	getgroup( file2, arr2)
	## 合并数据 按左/右 ##
	if( align ~/^right$/) 
		join( arr2, arr1)
	else
		join( arr1, arr2)
}

function join( lrr1, lrr2){
	## 合并函数 #
	for( i in lrr1) {
		if( i in lrr2) 
			print i,lrr1[i], lrr2[i]
		else
			print "[" i "] isn't in right file. " > "/dev/stderr"
	}
}
function getgroup(file, arr , idx, n) {
	if( getline < file  > 0 ) {
		n++
		do {
		idx = $1;
		$1 = ""
		arr[ idx ] = $0
		n++
		} while ( getline < file > 0 )
	} else {
		print "file:[" file "] can't be read!" > "/dev/stderr"
		exit 1
	}
	return n
}
