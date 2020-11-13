#!/usr/bin/python
# python version 2.6.6
#script created to deal with merged prophages due to overlapping boundaries
#used to be in mat_gen.py to give specific colour to merged prophages
#but resulted in issues with BLAST hits between non-prophage areas being recorded as counts of prophages would be off

#imports
import os
import sys


#get arguments and save them as variables
temp_coord = sys.argv[1]
max_len = sys.argv[2]

output = "./temp/merged_prophage_coord.txt"

coordfile_list = []
with open(temp_coord) as coordfile:
    for line in coordfile:
        coordfile_list.append(line)

last_end = 1
merged_prophage_list = []
for prophage in coordfile_list:
    prophage = prophage.rstrip("\n")
    #dealing with overlapping prophage mergers
    start = int(prophage.split("_")[0])
    if start <= last_end:
        last_end = int(prophage.split("_")[1])
        merged_prophage_list[-1] = last_end
    else:
        last_end = int(prophage.split("_")[1])
        merged_prophage_list.append(start)
        merged_prophage_list.append(last_end)

outfile = open(output, 'a')
x=1
for coordinate in merged_prophage_list:
    if x % 2 == 0:
        new_prophage = new_prophage + "_" + str(coordinate)
        outfile.write(new_prophage + "\n")
    else:
        new_prophage = str(coordinate)
    x += 1

outfile.close()
exit()
