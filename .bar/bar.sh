#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors!
. ~/.bar/themes/nord

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val "
}


battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
	#printf "^c$red^^b$black^ B>> $get_capacity "
	printf "^c$black^ ^b$red^ BATT"
	printf "^c$white^ ^b$grey^ $get_capacity"
}


#mem() {
#	printf "^c$blue^^b$black^R>>"
#	printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
#

wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 直 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 睊 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^  "
	printf "^c$black^^b$blue^ $(date '+%I:%M %p') "
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ]
	interval=$((interval + 1))

    sleep 1 && xsetroot -name "$(cpu) $(battery) $(wlan) $(clock)"
done

