#!/usr/bin/awk -f

/^姓名/{ name = $2 }
/^年龄/{ age = $2 }
/^身高/{ height = $2}
/^地址/{ addr = $2 }
/^$/{ printf("%s %s %s %s\n", name, age, height, addr)}

