#!/usr/bin/env python
# -*- coding: utf-8 -*-
#########################################################################
# Author: zwker
# mail: xiaoyu0720@gmail.com
# Created Time: 2018年03月24日 星期六 09时55分19秒
#########################################################################

import urllib2

import sys 
import re
import os


if __name__ == '__main__':
	import inspect
	file_path = os.path.dirname(os.path.realpath(inspect.getfile(inspect.currentframe())))
	sys.path.insert(0, os.path.join(file_path, '../'))

import argparse
import atexit
import json
import base64
from shadowsocks.local import main 
from urlparse import urlparse, parse_qs

ssr_prefix = "ssr://"
ssr_prefix_len = len(ssr_prefix)

def get_parser():
	parser = argparse.ArgumentParser(description = u"decode the ss-qrcode-url and generate the config.json file for your shadowsocks client", epilog="this will help set the shadowsocks config.json faster.")
	parser.add_argument("-c", "--config" , nargs = '?' , default = '/tmp/ssr_config.json' , help = 'set the output filename, default ./config.json' )
	parser.add_argument("-d", "--daemon" , nargs = '?' , metavar = 'start/stop/restart' , choices = [ 'start','stop','restart'] , default = 'start' , help = 'daemon mode')
	parser.add_argument("-p", "--pid-file" , nargs = '?' , default = '/tmp/ssr.pid' , help = 'pid file for daemon mode')
	parser.add_argument("-l", "--log-file" , nargs = '?' , default = '/tmp/ssr.log' , help = 'log file for daemon mode')
	parser.add_argument("-q", "--quiet-mode" ,  action = 'store_false' ,  help = 'quiet mode, only show warnings/errors')
	parser.add_argument("ss_qrcode_url", nargs = '?' , default = 'ssr://MTU5Ljg5LjE1My4xNjA6NTA2NzpvcmlnaW46YWVzLTI1Ni1jZmI6cGxhaW46YVM1M2RYY3VjbVZrLz9vYmZzcGFyYW09JnByb3RvcGFyYW09JnJlbWFya3M9UkUxOFdGaDhXRmc2TVRjJmdyb3VwPWQzZDNMbk56Y25Ob1lYSmxMbU52YlE', help = 'shadowsocks qrcode png image url, eg. http://ss.ishadowx.com/img/qr/jpaxxoo.png . choices:[us|sg|jp][abc]. ssr-uri' )
	### ssr://NDUuMzIuMTc0LjEzOjgwOmF1dGhfc2hhMV92NDphZXMtMjU2LWN0cjpwbGFpbjpNWEZoZWpKM2MzZ3paV1JqSkZKR1Zn
	### ssr://MTU5Ljg5LjE1My4xNjA6NTA2NzpvcmlnaW46YWVzLTI1Ni1jZmI6cGxhaW46YVM1M2RYY3VjbVZrLz9vYmZzcGFyYW09JnByb3RvcGFyYW09JnJlbWFya3M9UkUxOFdGaDhXRmc2TVRjJmdyb3VwPWQzZDNMbk56Y25Ob1lYSmxMbU52YlE
	return parser.parse_args()

def b64pading(enc):
	'''
	base64补充等号填充方法
	'''
	if (len(enc) % 4) != 0 :
		enc += '=' * (4 - (len(enc) % 4))
		print("b64pading:[{0}]".format(enc))
	
	return enc
	
def decode_ssr_uri( ssr_uri_string ):
	'''
	decode shadowsocksR uri string , format like ssr://aldkfaldkfdlwofdfj...dfa= 
	'''
	ssr_encode_string = ""
	ssr_decode_string = ""
	conf_json = dict()
	if( ssr_uri_string.startswith( ssr_prefix ) ):
		ssr_encode_string = ssr_uri_string[ssr_prefix_len:]
	print("ssr_encode_string:{0}".format(ssr_encode_string))
	## split different part of params ###
	ssr_split_array = ssr_encode_string.split('_')
	print("ssr_split_array:len:{0}".format(len(ssr_split_array)))
	if len(ssr_split_array) == 2 :
		i1_ssr = base64.decodestring( b64pading( ssr_split_array[0] ) );
		i2_ssr = base64.decodestring( b64pading( ssr_split_array[1] ) );
		ssr_decode_string = "{0}?obfsparam={1}".format( i1_ssr , i2_ssr) 
	else :
		ssr_decode_string = base64.decodestring( b64pading(ssr_encode_string) )

	print("ssr_decode_string:{0}".format(ssr_decode_string))

	
	ssr_decode_string = ssr_prefix + ssr_decode_string
	ssr_params=parse_qs(urlparse(ssr_decode_string).query)
	print("urlparse.netloc:{0}".format(urlparse(ssr_decode_string)))
	result = urlparse(ssr_decode_string).netloc
	## SSR格式：ssr://server:server_port:method:protocol:obfs:base64-encode-password/?obfsparam=base64-encode-string&protoparam=base64-encode-string&remarks=base64-encode-string&group=base64-encode-string
	##服务端信息设置
	server_info = result.split(':')
	server_ip , server_port , protocol, method ,obfs , password  = server_info[0], server_info[1],server_info[2],server_info[3],server_info[4],base64.decodestring( b64pading(server_info[5]) )
	server_port = int(server_port)
	## 参数设置
	for i in [ 'remarks', 'group', 'obfs_param', 'protocol_param' ] :
		if i in ssr_params:
			print('{0} = {1}'.format( i, b64pading(ssr_params[ i ][0])))
			conf_json[ i ] = base64.decodestring( b64pading(ssr_params[ i ][0]))
		else:
			conf_json[ i ] = ""

	conf_json['fast_open'] = False
	conf_json['local_address'] = '0.0.0.0'
	conf_json['local_port'] = 1080 
	conf_json['timeout'] = 600
	conf_json['udp_timeout'] = 60
	conf_json['dns_ipv6'] = False
	conf_json['connect_verbose_info'] = 0
	conf_json['redirect'] = ""
	conf_json['server'] = server_ip
	conf_json['server_port'] = server_port
	conf_json['method'] = method
	conf_json['password'] = password
	conf_json['protocol'] = protocol
	conf_json['obfs'] = obfs

	return conf_json

def main_task():
	'''
	功能为根据指定的 ssr-qrcode-url 生成ssr配置信息并输出为config文件
	'''

	default_url_pattern = "https://en.ishadowx.net/img/qr/{}xxoo.png"

	args = get_parser()

	## get the  qrcode url address 
	ss_url = args.ss_qrcode_url

	## get the ss-uri string 
	if ss_url.startswith(ssr_prefix) :
		ss_uri = ss_url
	else:
		print("invalid ssr url,it should be started with ssr://")
		sys.exit(1)
	

	## decode the ss-uri string
	conf_json = decode_ssr_uri( ss_uri )


	## 5.generate config.json file
	args.config = os.path.realpath(args.config)
	file_obj = open( args.config , 'w')
	
	jsonfile = json.dumps(conf_json,sort_keys=True, indent=4)
	print("jsonfile:\n{0}\n".format(jsonfile))
	file_obj.write(jsonfile)
	file_obj.close()

	## 设置执行参数 ###
	sys.argv = [ sys.argv[0] , "-c" , args.config , '-d', args.daemon , '-q', '--pid-file', args.pid_file , '--log-file', args.log_file ]
	if  args.quiet_mode :
		sys.argv += "-q" 
	## 执行shadowsocks 主函数 ##
	sys.exit(main())

if __name__ == "__main__" :
	main_task()

