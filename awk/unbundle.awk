#!/usr/bin/awk -f
# unbundle.awk 拆包一个文件到多个文件中
/^FILENAME:/{ if (prev != "") close(prev); prev=$2; }
!/^FILENAME:/ && prev != "" { print $0 > prev }

