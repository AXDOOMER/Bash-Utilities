// Copyright (c) Alexandre-Xavier Labonté-Lamoureux, 2017

#include <iostream>
#include <string>
using namespace std;

string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

void Generate(const size_t& l, string s)
{
	if (l == 0) {
		cout << s << endl;
		return;
	}

	for (size_t i = 0; i < chars.size(); i++)
		Generate(l - 1, s + chars[i]);
}

void Crack(const size_t& pl)
{
	size_t length = 1;
	while (length <= pl) {
		Generate(length, "");
		length++;
	}
}

int main(int argc, char* argv[])
{
	if (argc >= 3)
		chars = argv[2];

	if (argc >= 2)
		Crack(atoi(argv[1]));
	else
		cout << "cracker [length] [chars]" << endl;
}
