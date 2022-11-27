#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Shelyak/Shelyak.conf &> /dev/null &
# conky -c $HOME/.config/conky/Shelyak/Sirius.conf &> /dev/null &
