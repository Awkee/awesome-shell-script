#!/bin/awk -f

BEGIN{
    print "hello world!"
}

{
#    print "this is a test!"
    print $0
}

END{
    print "This is the end line of awk command!"
}
