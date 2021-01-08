#!/bin/awk -f
function usage(fname) {
	print "Usage:"
	print "	"fname" +n maxline file1..."
	print "	"fname" +h : get help info"
}
BEGIN{
	maxline = 5
    for( i = 0; i < ARGC ; i++)
    {
        if( ARGV[i] == "+n" )
        {
			maxline = int(ARGV[i+1])
            ARGV[i] = ""
            ARGV[i+1] = ""
        }
		else if( ARGV[i] == "+h" ){
			usage(ARGV[0])
			exit 1
		}
    }
}

FNR == 1 , FNR == maxline { 
	printf("%s:%03d:%s\n",FILENAME,FNR,$0)
}
