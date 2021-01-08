#!/usr/bin/awk -f
# topological sort of a graph

{
	if(!($1 in pcnt))
		pcnt[$1] = 0
	pcnt[$2]++
	slist[$1, ++scnt[$1]] = $2
}
END{
	for( node in pcnt) {
		nodecnt ++
		if( pcnt[node] == 0) # if it has no predecessors
			q[++back] = node # queue node
	}
	for( front = 1; front <= back; front++){
		printf(" %s", node = q[front])
		for( i = 1; i <= scnt[node]; i++)
			if( --pcnt[slist[node,i]] == 0 )
			q[++back] = slist[node,i]
	}
	if( back != nodecnt)
		print "\nerror:input contains a cycle"
	printf("\n")
}
