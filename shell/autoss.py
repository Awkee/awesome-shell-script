#!/usr/bin/python
# -*- coding: utf-8 -*-
#########################################################################
# Author: zwker
# mail: xiaoyu0720@gmail.com
# Created Time: 2017年08月27日 星期日 09时55分19秒
#########################################################################

import urllib2

import sys 
import re
import json
import zbar
from PIL import Image
import wget
import base64
import os
import argparse
import atexit
from shadowsocks.local import main 


def get_parser():
	parser = argparse.ArgumentParser(description = u"decode the ss-qrcode-url and generate the config.json file for your shadowsocks client", epilog="this will help set the shadowsocks config.json faster.")
	parser.add_argument("-c", "--config" , nargs = '?' , default = '/tmp/config.json' , help = 'set the output filename, default ./config.json' )
	parser.add_argument("-d", "--daemon" , nargs = '?' , metavar = 'start/stop/restart' , choices = [ 'start','stop','restart'] , default = 'start' , help = 'daemon mode')
	parser.add_argument("-p", "--pid-file" , nargs = '?' , default = '/tmp/ss.pid' , help = 'pid file for daemon mode')
	parser.add_argument("-l", "--log-file" , nargs = '?' , default = '/dev/null' , help = 'log file for daemon mode')
	parser.add_argument("-q", "--quiet-mode" ,  action = 'store_false' ,  help = 'quiet mode, only show warnings/errors')
	parser.add_argument("ss_qrcode_url", nargs = '?' , default = 'https://en.ss8.fun/images/server02.png', help = 'shadowsocks qrcode png image url, eg. http://ss.ishadowx.com/img/qr/jpaxxoo.png . choices:[us|sg|jp][abc], https://en.ss8.fun/images/server01.png , https://en.ss8.fun/images/server02.png , https://en.ss8.fun/images/server03.png . ss-uri' )
	return parser.parse_args()

def decode_qrcode( qrcode_file):
	'''
	decode the qrcode png image file,then return the image object result
	'''
	if  os.path.isfile( qrcode_file ) :
		# create a scanner
		scanner = zbar.ImageScanner()
		# configurue the reader
		scanner.parse_config('enable')
		# obtain the image data
		pil = Image.open( qrcode_file ).convert('L')
		width, height = pil.size
		raw = pil.tobytes()
		# wrap image data
		image = zbar.Image(width, height, 'Y800', raw)
		# scan the image for barcodes
		scanner.scan(image)
	else:
		print "qrcode image file[" + qrcode_file + "] is not a file ."

	return image



def main_task():
	'''
	功能为根据指定的 ss-qrcode-url 获取ss配置信息并输出为config文件

	1. 获取SS-QRCode的png文件
	2. 通过Image获取ss-url信息 
	3. 使用base64解析ss-url信息
	4. 解析解码后的ss配置信息
	5. 根据解析后的配置生成json配置文件config.json
	'''

#    default_url_pattern = "https://ss.ishadowx.net/img/qr/{}.png"
#    default_url_pattern = "https://ss.ishadowx.net/img/qr/{}xxoo.png"
#    default_url_pattern = "https://b.ishadow.tech/img/qr/{}xxoo.png"
#    default_url_pattern = "https://go.ishadowx.net/img/qr/{}xxoo.png"
	default_url_pattern = "https://global.ishadowx.net/img/qr/{}xxoo.png"

	args = get_parser()

	## get the  qrcode url address 
	if args.ss_qrcode_url in [ "usa", "usb","usc" , "jpa" , "jpb", "jpc" , "sga" , "sgb" , "sgc" ] :
		ss_url = default_url_pattern.format( args.ss_qrcode_url )
	else:
		ss_url = args.ss_qrcode_url

	## get the ss-uri string 
	if ss_url.startswith("ss://") :
		ss_uri = ss_url
	else:
		print "begin to download :[" + ss_url + "]"
		ss_filename = wget.download( ss_url )
		image = decode_qrcode( ss_filename)
		for symbol in image:
			if symbol.data.startswith("ss://" ) :
				ss_uri = symbol.data
				os.remove(ss_filename)
				break

	## decode the ss-uri string
	if ss_uri.startswith("ss://") :
		result = base64.decodestring( ss_uri[5:] )
		server_info = result.split(':')
		server_user = server_info[1].split('@')
		method , password , server_ip , server_port  = server_info[0], server_user[0],server_user[1],server_info[2]
		server_port = int(server_port)


	## 5.generate config.json file
	args.config = os.path.realpath(args.config)

	file_obj = open( args.config , 'w')
	#print jsonfile
	conf_json = dict()
	conf_json['fast_open'] = False
	conf_json['local_address'] = '0.0.0.0'
	conf_json['local_port'] = 1080 
	conf_json['method'] = method
	conf_json['password'] = password
	conf_json['server'] = server_ip
	conf_json['server_port'] = server_port
	conf_json['timeout'] = 600
	conf_json['workers'] = 1

	#print conf_json
	jsonfile = json.dumps(conf_json,sort_keys=True, indent=4)
	print jsonfile
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

