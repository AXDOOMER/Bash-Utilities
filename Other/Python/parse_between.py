#!/usr/bin/env python

# Copyright (c) Alexandre-Xavier Labonte-Lamoureux, 2017

import sys
import numbers

# Parser
def parse(textfile):
	myfile = open(textfile, "r")
	datastring = myfile.read()

	first_delimiter = '\"'
	second_delimiter = '\"'

	index = 0
	while(index < len(datastring)):
		first = datastring.find(first_delimiter, index, len(datastring))

		if (first == -1):
			break;

		second = datastring.find(second_delimiter, first + len(first_delimiter), len(datastring))

		if (second == -1):
			break;

		index = second + len(second_delimiter);

		foundstring = datastring[first + len(first_delimiter):second]
		if (len(foundstring) > 0 and not foundstring.isdigit()):
			print(foundstring)

	quit()

def main():
	if len(sys.argv) < 2:
		print("No enough arguments. How to use:")
		print("parse_between.py [FILE]")
		quit()

	textfile = sys.argv[1]

	# Parsing function
	parse(textfile)

# Do stuff
if __name__ == "__main__":
	main()
