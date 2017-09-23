#!/usr/bin/env python

# Copyright (c) Alexandre-Xavier Labonté-Lamoureux, 2017
# Web page tag extractor

import sys
try:
	from bs4 import BeautifulSoup
except ImportError:
	print("This script will not run without python-bs4 (for Python 2) or python3-bs4 (for Python 3)")
	quit()

# Tags to be extracted
tags = [ "title", "h1", "h2", "h3", "a"]

# Parsing algorithm
def parse(xml):
	content = BeautifulSoup(xml, 'html.parser')

	for tag in tags:
		# Print the data extracted from the tags and remove semicolons
		for elem in content.find_all(tag):
			print(elem.get_text().replace(";", ""))

# Main
def main():
	if len(sys.argv) < 2:
		print("No file specified.")
		quit()

	try:
		# Parsing function
		parse(open(sys.argv[1], "r"))
	except IOError:
		print("File could not be found: " + sys.argv[1])
		quit()

# Do stuff
if __name__ == "__main__":
	main()
