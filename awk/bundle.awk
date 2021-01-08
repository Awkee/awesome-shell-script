#!/usr/bin/awk -f
# bundle.awk 打包多个文件到一个文件中
FNR==1{ print "FILENAME: "FILENAME}
{print $0 }
