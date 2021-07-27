#!/usr/bin/awk -f
# table data to markdown table format
# 两列用竖线分割 ， 第一行为标题
BEGIN{
    if(ARGC > 1) {
        for(i = 1; i<ARGC; i++){
            if( ARGV[i] == "-F" || ARGV[i] == "+F" ){
                FS = ARGV[i+1]
                printf("Change FS=[%s]\n\n",FS);
                ARGV[i]=""
                ARGV[i+1]=""
            }
        }
    }
}
NR==1{ # 第一行作为标题
    max_col = NF
}
NR==2{ # 第二行，开始前输出表格的分隔符线
    txt = ""
    for( i = 0; i < max_col;i++)
        txt = txt "|:---"
    cnt[maxl++] = txt "|"
}
NF!=max_col{
    printf("invalid data (NF[%d]!=max_col[%d]):line_data=[%s]\n", NF, max_col, $0)
}
NF==max_col{ # 对列数为max_col的行进行格式化处理
    txt = ""
    gsub("\\|","\\\\|")
    gsub("<","\\<")
    gsub("&","\\\\&")
    for( i = 1; i <= max_col;i++)
        txt = txt "| " $i
    cnt[maxl++] = txt "|"
}END{  # 最后输出转换后的Markdown表格格式
    print("\n\n")
    for(j=0; j < maxl; j++)
        printf("%s\n",cnt[j])
}
