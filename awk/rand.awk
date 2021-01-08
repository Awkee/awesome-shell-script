#!/usr/bin/awk -f
## 功能： 输出数值数列
## 参数： r c, r c m ,
## 输出： 输出 r行 , c列随机数 ,最大值为 m(默认100)

function usage(f){
    printf("Usage: %s r c\n", f);
    printf("       %s r c m\n", f);
    printf("其中  r :行数, c :列数 , m :最大数值，默认100 \n");
}
BEGIN{
  if( ARGC == 3 ){r = ARGV[1] ; c = ARGV[2] ; m = 100}
  else if( ARGC == 4 ){r = ARGV[1] ; c = ARGV[2] ; m = ARGV[3] }
  else {
    usage(ARGV[0])
    exit 1
  }
  #"date +%N" | getline sr
  "echo $RANDOM" | getline sr
  srand(sr)
  for( i = 0; i< r ; i ++)
  {
      for(j = 0 ; j < c -1; j++)
        printf("%d ", rand()*m); 
      printf("%d\n", rand()*m); 
  }
}

