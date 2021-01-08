#!/usr/bin/awk -f
BEGIN{
    for( i = 0; i < ARGC ; i++)
    {
		print "ARGV["i"]="ARGV[i]
        if( ARGV[i] == "+var" )
        {
			var = ARGV[i+1]
            ARGV[i+1] = ""
            ARGV[i] = ""
        }
    }
    OFS=":"
    ORS="\n"
}

{

    print FILENAME,NR,var,$0
}
