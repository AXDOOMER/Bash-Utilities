#!/usr/bin/env python
# Copyright (c) Alexandre-Xavier Labonte-Lamoureux, 2017

import sys

chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

def Generate(length, word):
	if (length == 0):
		print(word)
		return

	for i in range(len(chars)):
		Generate(length - 1, word + chars[i])

def Crack(pl):
	length = 1
	while (length <= pl):
		Generate(length, "")
		length += 1

def Main():
	if (len(sys.argv) >= 3):
		global chars
		chars = sys.argv[2]

	if (len(sys.argv) >= 2):
		Crack(int(sys.argv[1]))
	else:
		print("cracker [length] [chars]")

if __name__ == "__main__":
	Main()
