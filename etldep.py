#!/usr/bin/env python

import json
import sys
from collections import deque





def printst(prefix, subtree, queue):
    for key,val in subtree.iteritems():
        if type(val) is dict:
            printst( prefix, val, queue)
        elif key.endswith( "job_dep_list" ):
            for dep in val:
                print prefix + ":" + dep
                queue.append( dep )
        elif key.endswith( "query" ):
            print "QUERY: "+val

def printjsf( file_name, queue ):
    #print file_name + ":"
    with open(file_name, 'rb') as file:
        parsed = json.load(file, strict=False)
        printst( file_name, parsed, queue )

if __name__ == "__main__":
    queue = deque([sys.argv[1]])
    while queue:
        file_name = queue.popleft()
        printjsf( file_name, queue )
