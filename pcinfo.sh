# Copyright (C) Alexandre-Xavier Labonté-Lamoureux

# GNU/LINUX
uname -msr

# CPU info
cat /proc/cpuinfo | head | grep "@"

# RAM
head -n 1 /proc/meminfo

# network cards
lspci | egrep -i --color 'network|ethernet' | cut -d: -f2- | cut -d: -f2-

# GPU
lspci | grep VGA | cut -d: -f2- | cut -d: -f2-

# Audio card
lspci | grep -i audio | cut -d: -f2- | cut -d: -f2-



