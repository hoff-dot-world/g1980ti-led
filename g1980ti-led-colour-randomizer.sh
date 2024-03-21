#!/bin/bash

#   g1980ti-led-colour-randomizer.sh - Gigabyte G1 980 Ti LED Colour Randomizer Script
#   Copyright (C) 2020/2024 hoff.industries

#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.

INTERVAL=$1
PREVIOUS_COLOUR=0
colours=([0]=0x14 [1]=0x11 [2]=0x12 [3]=0x13 [4]=0x15 [5]=0x16 [6]=0x17)
while true
do
    SELECTED_COLOUR=${colours[$RANDOM % ${#colours[@]}]}
    if [ $SELECTED_COLOUR = $PREVIOUS_COLOUR ]
    then
        continue
    fi
    for i in 1 2 3 4
    do
        sudo i2cset -y 2 0x48 "$SELECTED_COLOUR" 0x00
    done
    PREVIOUS_COLOUR=$SELECTED_COLOUR
    sleep $INTERVAL
done
