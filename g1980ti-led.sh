#!/bin/bash

#   g1980ti-led.sh - Gigabyte G1 980 Ti LED Control Script
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

COLOUR=$1
declare -A colours
colours=(["blue"]=0x14 ["red"]=0x11 ["green"]=0x12 ["yellow"]=0x13 ["magenta"]=0x15 ["cyan"]=0x16 ["white"]=0x17 ["off"]=0x21)
sudo modprobe i2c-dev
for i in 1 2 3 4
do
    sudo i2cset -y 2 0x48 "${colours["$COLOUR"]}" 0x00
done
