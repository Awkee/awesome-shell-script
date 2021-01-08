#!/usr/bin/awk -f
## date2day.awk  将日期转换为天数
##  日期转换为总天数
######################################
function check_date( y, m, d, ret) {
	ret = 0
	if( y !~/[0-9]{1,4}/)                    ret = 1
	if( m !~/^(0?[1-9]|1[0-2])$/)            ret = 2
	if( d !~/^(0?[1-9]|[1-2][0-9]|3[0-1])$/) ret = 3
	return ret
}
function is_leap(y){
        return (( y%4 == 0 && y%100 != 0 ) ||  y%400 == 0 ) ? 1 : 0
}
function yearofday(y1,y2, day){
	if( y1 > y2 ) return -1
	for( i = y1; i< y2 ; i++) {
		day += 365
		if(is_leap(i)) day ++
	}
	return day
}
function monthofday(m0, m1, days, ret){

	if(m0 !~/^(0?[1-9]|1[0-2])$/) return -1
	if(m1 !~/^(0?[1-9]|1[0-2])$/) return -2

	mo[1] = mo[3] = mo[5] = mo[7] = mo[8] = mo[10] = mo[12] = 31
	mo[4] = mo[6] = mo[9] = mo[11]  = 30
	mo[2] = 28
	days = 0
	for( i = m0; i < m1 ; i++) {
		days += mo[i]
		if( is_leap(y) && i == 2) 
			days ++
	}
	return days
} 
function date2day( str_date, days, ret){
	y = int(substr(str_date,1,4))
	m = int(substr(str_date,5,2))
	d = int(substr(str_date,7,2))
	ret = check_date(y,m,d) 
	if( ret != 0 ) exit(ret)
	days = 0

	ret = yearofday( 0, y) 
	if( ret < 0 ) return ret
	days += ret

	ret = monthofday( 1, m) 
	if( ret < 0 ) return ret
	days += ret
	days += d
	return days
}
function datecmp(dt1, dt2, ret1, ret2) {
	ret1 = date2day( dt1 )
	if( ret1 < 0 ) return ret1
	ret2 = date2day( dt2 )
	if( ret2 < 0 ) return ret2
	return ret2 - ret1
}
NF==1{
	print "日期转换为总天数:[" $1 "] ==> " date2day($1)
}
NF==2{
	print "日期天数比较: ["$1 "]:[" $2 "] ==> " datecmp($1, $2)
}
