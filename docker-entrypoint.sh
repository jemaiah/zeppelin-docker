#!/bin/bash
set -eo pipefail
shopt -s nullglob

wantHelp=
for arg; do
	case "$arg" in
		-'?'|--help|--print-defaults|-V|--version)
			wantHelp=1
			break
			;;
	esac
done

if [[ ${ZEP_ADM_PASS} != "" ]]
then
	echo " setting zeppelin admin password"
	sed -i -e "s/password1/${ZEP_ADM_PASS}/g" /home/zeppelin/latest/conf/shiro.ini
fi
if [[ ${ZEP_USER1_PASS} != "" ]]
then
	echo " setting zeppelin USER1 password"
	sed -i -e "s/password2/${ZEP_USER1_PASS}/g" /home/zeppelin/latest/conf/shiro.ini
fi
if [[ ${ZEP_USER2_PASS} != "" ]]
then
	echo " setting zeppelin USER2 password"
	sed -i -e "s/password3/${ZEP_USER2_PASS}/g" /home/zeppelin/latest/conf/shiro.ini
fi
if [[ ${ZEP_USER3_PASS} != "" ]]
then
	echo " setting zeppelin USER3 password"
	sed -i -e "s/password4/${ZEP_USER3_PASS}/g" /home/zeppelin/latest/conf/shiro.ini
fi

$@

