#!/usr/bin/awk  -f
######################################################
##  This is a simple awk command script             ##
######################################################

function usage(){
    printf("Usage: diff.awk file1 file2\n");
}
BEGIN{
    OFS=":"
	if( ARGC == 1){
		usage()
		exit 2
	}
	for( i = 1; ARGV[i]~/^+[a-z|A-Z]+$/; i+= 2)
	{
		if( ARGV[i] == "+b" )
		{
			flag_blank = ARGV[i+1]
		}
		ARGV[i] = ""
		ARGV[i+1] = ""
	}
	print ARGC,i;
    if(ARGC - i + 1!= 3) {
		printf("ARGV :%d\n", ARGC - i + 1);
        usage()
        exit 1
    }
    while( getline < ARGV[i] > 0 ) {
		if( flag_blank == 1 ) {
			gsub(/[ 	]+/,"")
			arr[$0]++
		}
	}
    j = 0
	print i, ARGV[i] , ARGV[i+1]
    while( getline < ARGV[i+1] > 0 ) {
        j++
		line = $0;
		if( flag_blank == 1 ) {
			gsub(/[ 	]+/,"")
		}
        if( $0 in arr ){
            print "SAME", j, line
        } else {
            print "DIFF", ARGV[i+1], j, line  > "/dev/stderr"
        }
    }
}

