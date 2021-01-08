#!/usr/bin/awk -f

BEGIN{ FS="\n"; RS = "";}
/^deposit/{ deposits += field("amount"); next }
/^check/{ checks += field("amount"); next }
END{
	printf("deposits $%.2f, checks $%.2f\n", deposits, checks);
}
function field(name, i,f){
	for(i = 1; i <=NF; i++){
		split($i, f, /[ \t]/) 
		if( f[1] == name )
			return f[2]
	}
	printf("error: no field %s in record\n%s\n", name,$0)
}
