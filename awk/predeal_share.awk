#!/usr/bin/awk -f

BEGIN{ FS=","}
NF==7 && $5!="" && $6 != "" && $7 !=""{ print $5,$6,$7}
