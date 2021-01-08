#!/usr/bin/awk -f
# make.awk --   a simple awk version of make program 

BEGIN{
	while( getline < "makefile" > 0) {
		if( $0 ~/^[A-Za-z]/) {
			sub(/:/," ")
			if( ++names[nm = $1] > 1)
				error(nm "is multiply defined")
			for(i = 2; i <= NF; i++)
				slist[nm, ++scnt[nm]] = $i
		} else if( $0 ~/^\t/) {
			cmd[nm] = cmd[nm] $0 "\n"
		} else if( NF > 0) {
			error("illegal line in makefile: " $0)
		}
	}
	ages()
	if(ARGV[1] in names){
		if( updates(ARGV[1]) == 0 )
			print ARGV[1] " is up to date"
	} else {
		error( ARGV[1] " is not in makefile")
	}
}
function ages( f, n, t){
	for( t = 1; ("ls -t"| getline f) > 0 ; t++) 
		age[f] = t
	close("ls -t")
	for( n in names)
		if( !(n in age))
			age[n] = 9999
}

function updates( n, changed, i, s) {
	if( !(n in age)) error(n " does not exist")
	if( !(n in names)) return 0
	changed = 0
	visited[n] = 1
	for(i = 1; i <= scnt[n]; i++){
		if( visited[s = slist[n, i]] == 0 ) updates(s)
		else if( visited[s] == 1)
			error(s " and " n " are circularly defined")
		if(age[s] <= age[n]) changed++
	}
	visited[n] = 2
	if( changed || scnt[n] == 0){
		printf("%s", cmd[n])
		system(cmd[n])
		ages()
		age[n] = 0
		return 1
	}
	return 0
}
function error(s) { print "error: " s; exit }
