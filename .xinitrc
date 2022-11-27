#!/bin/sh

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
#xrandr --dpi 96
#
## add your autostart stuffs here
#xset r rate 200 40 &
bar.sh &
sxhkd &
picom &
xrandr --output eDP-1 --brightness .8 &
xset r rate 250 60 &
setxkbmap -option "caps:escape" &

while type dwm >/dev/null; do dwm && continue || break; done
#nitrogen --set-zoom-fill --random ~/Wallpaper/landscape --save &
#dashboard &
#status_bar &
# run bar script and dwm ( do not remove this ) 
#dwmblocks &

