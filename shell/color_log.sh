
## Attribute codes:
## 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed 
## Text color codes:
## 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=Light gray
## 90=Dark gray 91=Light red 92...97=White
## Background color codes:
## 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

## \033[0m 关闭所有属性 
## \033[1m 设置高亮度 
## \033[4m 下划线 
## \033[5m 闪烁 
## \033[7m 反显 
## \033[8m 消隐 
## \033[30m — \33[37m 设置前景色 
## \033[40m — \33[47m 设置背景色 
## \033[nA 光标上移n行 
## \033[nB 光标下移n行 
## \033[nC 光标右移n行 
## \033[nD 光标左移n行 
## \033[y;xH设置光标位置 
## \033[2J 清屏 
## \033[K 清除从光标到行尾的内容 
## \033[s 保存光标位置 
## \033[u 恢复光标位置 
## \033[?25l 隐藏光标 
## \033[?25h 显示光标


## 突出显示内容
white_line()
{
    printf "\033[0;37m $@ \033[0m"
}
red_line()
{
    printf "\033[0;31;1m $@ \033[0m"
    echo
}
green_line()
{
    printf "\033[0;32;7m $@ \033[0m"
}

println()
{
    echo
    white_line ">-------------------------$@--------------------------------<"
    echo
}

blankln()
{
    white_line "<-------------------------------------------------------------------------->"
    echo
}
