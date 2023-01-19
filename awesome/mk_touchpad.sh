#!/bin/sh

# trackpad
xinput set-prop 11 305 1
xinput set-prop 11 284 1
xinput set-prop 11 302 10
xinput set-prop 11 293 0.02

#mouse
xinput set-prop 15 293 -0.35 &

# init
echo "Init.."
# xautolock -time 20 -locker ~/.config/awesome/lock.sh &
