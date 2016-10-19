# Copyright (C) Alexandre-Xavier Labonté-Lamoureux
# Do what the fuck you want with it...

# GNU/LINUX
uname -msr

# ess /proc/cpuinfo  | grep "@"
lscpu | grep "@"

# RAM
head -n 1 /proc/meminfo

# network cards
lspci | egrep -i --color 'network|ethernet' | cut -d: -f2- | cut -d: -f2-

# GPU
lspci | grep VGA | cut -d: -f2- | cut -d: -f2-

# Audio card
lspci | grep -i audio | cut -d: -f2- | cut -d: -f2-



