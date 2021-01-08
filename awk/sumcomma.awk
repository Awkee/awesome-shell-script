#!/usr/bin/awk -f
# sumcomma - 计算使用逗号表达数字的总和
# 例如 123,456.78

{ gsub(",",""); sum += $0 }
END{ print sum}

