#!/usr/bin/python3

# Copyright (c) Alexandre-Xavier Labonté-Lamoureux, 2017-2018
# Script that finds IP addresses in a file and gets information about them

import re
import os
import sys
import urllib.request
from bs4 import BeautifulSoup

# Country code of IPs to check for
countries = ['US', 'CA', 'MX']
description = "North American IPs"

# Function that validates an IP
def isValidDottedIPv4(s):
	x = s.split('.');
	if len(x) == 4:
		if int(x[0]) <= 255 and int(x[1]) <= 255 and int(x[2]) <= 255 and int(x[3]) <= 255:
			return True
	return False

# Scan each file in the current directory unless specific files are specified on the command line

if len(sys.argv) > 1:
	files = sys.argv
	files.pop(0)
else:
	files = os.listdir()

# Scan every line of all the required files for IP addresses. Check them online to see if they are Canadian. 

iplist = []

for filename in files:
	# Should not be a directory
	if os.path.isfile(filename):
		with open(filename) as f:
			for line in f:
				# Do the regex on the line, get matches
				matches = re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}', line)
				# Supports multiple IPs on the same line
				for match in matches:
					if isValidDottedIPv4(match):
						iplist.append(match)

# Print list of IPs
for ip in iplist:
	print(ip)

# Print the IPs which are in the countries list
print("\nIf any " + description + " are found, they will be printed bellow. This may take a while.")

for ip in iplist:
	try:
		resp = urllib.request.urlopen('http://api.geoiplookup.net/?query=' + str(ip)).read()
		# Extract country code from XML
		soup = BeautifulSoup(resp, "lxml")
		if soup.find('countrycode').string in countries:
			print(ip)
	except urllib.error.HTTPError as e:
		# Catch problems with the site. The IP 45.178.170.100 is valid, but will return 404. This may happen with other IPs.
		print("Failed to check IP '" + str(ip) + "', site API returned a " + str(e.code) + ".")

