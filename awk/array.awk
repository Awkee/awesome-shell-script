
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
