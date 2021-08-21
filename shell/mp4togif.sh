#!/usr/bin/env bash
#########################################
##
##  Mp4 文件 转为 GIF 图片 脚本
##
#########################################



# 输入源文件路径
in_file=""
# 输出文件名
out_file="out.gif"
# 设置输出帧率
use_fps=5
ss="00:00:00"
to="00:00:06"
vf="512:-1"



usage() {
    cat <<END
Usage:
    `basename $0` [-h]  for help
    `basename $0` [-o 输出文件名 ] [-r 每秒帧数] [-s 开始截取位置] [-t 结束截取位置] [-v Video输出尺寸] input_file
参数说明：
    -o 输出文件名 ： 输出文件名，默认为"out.gif"
    -r 每秒帧数 ： 控制每秒钟输出图片数量，默认5
    -s 开始截取位置 : 起始时间设置格式为 hh:mm:ss,默认值为 00:00:00 
    -t 结束截取位置 : 结束时间设置格式为 hh:mm:ss,默认值为 00:00:06
    -v Video输出尺寸,格式如 256 , 会输出 256x256尺寸大小，默认值 512

END
}
############ 开始执行入口 ######

while getopts h:o:r:s:t:v: arg_val
do
    case "$arg_val" in
        o)
            out_file="$OPTARG"
            ;;
        r)
            use_fps="$OPTARG"
            ;;
        s)
            ss="$OPTARG"
            ;;
        t)
            to="$OPTARG"
            ;;
        v)
            vf="$OPTARG:-1"
            ;;
        h|*)
            usage
            exit 0
            ;;
    esac
done

shift $(($OPTIND - 1 ))

if [ "$#" != "1" ] ; then
        usage
        exit 2
fi

if ffmpeg -h >/dev/null ; then
    echo "CHECK: ffmpeg command has already been installed."
else
    echo "CHECK: ffmpeg command does not install on your computer."
    exit 1
fi

in_file="$1"


# 转换目标规格： 尺寸-512x512，转换从3秒到6秒，每秒15帧图片(15*3=45张图片) 预计GIF文件大小为
ffmpeg \
  -i ${in_file} \
  -r ${use_fps} \
  -vf scale=${vf} \
  -ss ${ss} -to ${to} \
  ${out_file%.*}.GIF