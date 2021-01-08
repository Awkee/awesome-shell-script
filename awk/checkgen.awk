#!/usr/bin/awk -f
# checkgen.awk 自动生成检查规则程序

BEGIN{ FS = "\t+" }
{ printf("%s {\n\tprintf(\"line %%d, %s: %%s\\n\", NR,$0)\n}\n",$1,$2)}

