import  os, re
from sys import argv

project, readName, writeName = argv

file_read = open(readName, "r")
file_write = open(writeName, "w");

for line in file_read:
	textArray = re.split(r'[^0-9.]+', line);
	text = '\t'.join(textArray) +'\n'
	#print textArray, '\n'
	#print textArray[0], '\n'
	file_write.write(text)
	#break
file_write.close()
file_read.close()

