#!/usr/bin/awk -f
# rtsort  - reverse topological sort of a graph

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
			rtsort(node)
	}
	if( back != nodecnt)
		print "\nerror:input contains a cycle"
	printf("\n")
}
function rtsort(node,    i, s){
	visited[node] = 1
	for(i = 1; i <= scnt[node]; i++){
		if(visited[ s = slist[node, i]] == 0)
			rtsort(s)
		else if( visited[s] == 1)
			printf("error: nodes %s and %s are in a cycle\n", s, node)
	}
	visited[node] = 2
	printf(" %s", node)
	pncnt ++
}
