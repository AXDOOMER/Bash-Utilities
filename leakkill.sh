if [ $# -ne 1 ]; then
	echo "This script requires one parameter."
	echo "It's the maximum number of GB of RAM a process can use before it's killed."
	exit 1
fi

maxmem=$(( $1 * 1024 * 1024 ))

while true; do
	# enumerate every process running on the system
	pids=$(ps aux | awk '{print $2}' | grep -E '[0-9]')

	for i in $pids; do
		# get resident memory usage
		mem=$(ps -o rss= $i | awk '{$1=$1};1')

		if [ ! -z "$mem" ]; then

#			if [ "$mem" -gt 500000 ]; then
#				echo "PID $i uses $mem KB."
#			fi

			if [ "$mem" -gt "$maxmem" ]; then
				# display process info before it's killed
				top -bn1 -p $i
				kill -9 $i
			fi
		fi

	done

	# delay recheck
	sleep 5
done
