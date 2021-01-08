#!/bin/awk -f
### 模拟输出进度条更新 ##
BEGIN{
	i=0; 
	total_size = 0
	"date +%N" | getline sr
	srand(sr)
	while( i <= 10){
		total_size += int(rand()*100)
		printf("File a.mp4 downloading %d MB , processing %d%%\r" , total_size, i++ * 10);
		system("sleep 1")
	} 
	print "\nCongratulation!\nYour File a.mp4 is Downloaded , total_size :"total_size" MB !"
}
