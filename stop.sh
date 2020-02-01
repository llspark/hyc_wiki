#/usr/bin

pid=`ps -ef|grep mkdocs |grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]; then
	kill $pid  1>&2>/dev/null
else
	echo "mkdocs pid not exists"
fi

exit 0
