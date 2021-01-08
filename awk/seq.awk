#!/usr/bin/awk -f
## 功能： 输出数值数列
## 参数： q , p q , p q r ; 其中 q >= p ; r > 0
## 输出： 输出数值 1 - q , p - q , 或者 按照 r 从 p 递增 到 q

function usage(f){
    printf("Usage: %s q\n", f);
    printf("       %s p q\n", f);
    printf("       %s p q r\n", f);
    printf("其中  q >= p , r > 0\n", f);
}
BEGIN{
  if( ARGC == 2) {s = 1 ; e = ARGV[1] ; step = 1}
  else if( ARGC == 3 ){s = ARGV[1] ; e = ARGV[2] ; step = 1}
  else if( ARGC == 4 ){s = ARGV[1] ; e = ARGV[2] ; step = ARGV[3] }
  else {
    usage(ARGV[0])
    exit 1
  }
  for( i = s; i<= e ; i += step )
    printf("%d\n", i)
}

