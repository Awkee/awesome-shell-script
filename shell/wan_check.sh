#!/bin/sh
##########################
# 网络异常重启wan接口监控脚本
# 配置在调度表cron中
##########################

# 定义日志文件路径
LOG_FILE="/var/log/auto_restart_wan.log"

ping_host="www.baidu.com"

log_info() {
	echo "$(date): INFO : $*" >>"$LOG_FILE"
}
log_error() {
	echo "$(date): ERROR : $*" >>"$LOG_FILE"
}

check_wan() {
	# 检测网络连接是否正常
	ping -c 3 ${ping_host} >/dev/null
}

check_wan

if [ "$?" != "0" ]; then
	log_error "Network is down, restarting WAN interface"

	# 重启 WAN 接口
	/etc/init.d/network restart >/dev/null
	log_info "WAN interface restarted"
	sleep 10
	check_wan
	[ "$?" = "0" ] && log_info "restart WAN interface is ok" && return 0
	log_error "restart WAN interface is not ok, try again"
else
	log_info "Network is up, no action required"
fi
