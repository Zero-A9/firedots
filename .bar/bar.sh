#!/bin/dash


# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors!
. ~/.bar/themes/onedark

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val "
}

#pkg_updates() {
#	updates=$(doas xbps-install -un | wc -l) # void
#	# updates=$(checkupdates | wc -l)   # arch , needs pacman contrib
#	# updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)
#
#	if [ -z "$updates" ]; then
#		printf "^c$green^  Fully Updated"
#	else
#		printf "^c$green^  $updates"" updates"
#	fi
#}

battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
	printf "^c$red^^b$black^    $get_capacity "
}

#brightness() {
#	printf "^c$red^ B:"
#	printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
#}

#stor() {
#    sto="$( df -h | grep /dev/nvme0n1p3 | awk '{print $5}' )"
#    printf "^c$green^^b$black^ : $sto"
#}


mem() {
	printf "^c$blue^^b$black^ R:"
	printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

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

    sleep 1 && xsetroot -name "$(battery) $(mem) $(cpu) $(wlan) $(clock)"
done

#while true; do
#
#	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
#	interval=$((interval + 1))
#
#    xsetroot -name "$(battery)"
#    
#done
#
