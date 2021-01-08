#!/usr/bin/awk -f
# addcomma - 按照逗号格式表达数字
#    input: 数字
#    output:逗号格式表达数字
#    eg: rand.awk 30 1 99900000000 | ./addcomma.awk


{ printf("%-12s %20s\n", $0, addcomma($0))}
function addcomma(x, num) {
    if( x < 0 )
        return "-" addcomma(-x)
    num = sprintf("%.2f", x) # num is dddddd.dd
    while( num ~/[0-9][0-9][0-9][0-9]/)
        sub(/[0-9][0-9][0-9][,.]/, ",&", num)
    return num
}
