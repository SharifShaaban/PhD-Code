#!/usr/bin/python
# python version 2.6.6

#imports
import os
import sys
from itertools import count, product, islice
from string import ascii_uppercase

#get arguments and save them as variables
file_name = sys.argv[1]
temp_coord = sys.argv[2]
strain_len = int(sys.argv[3])

blast_hits = "./output/relevant" + file_name + ".blast.txt"

#get file length function
#def file_len(fname):
#    with open(fname) as f:
#        for i, l in enumerate(f):
#            pass
#    return i + 1

def multiletters(seq):
    for n in count(1):
        for s in product(seq, repeat=n):
            yield ''.join(s)

#pro_num = int(file_len(temp_coord))

coordfile_list = []
with open(temp_coord) as coordfile:
    for line in coordfile:
        coordfile_list.append(line)

blast_hits_list = []
coords_list = []
with open(blast_hits) as blastfile:
    for line in blastfile:
        split_line = line.split("\t")
        coords_list.append(split_line[6])
        coords_list.append(split_line[7])
        coords_list.append(split_line[8])
        coords_list.append(split_line[9])
        relevant_list = [split_line[6], split_line[7], split_line[8], split_line[9], split_line[3]]
        blast_hits_list.append(relevant_list)

start = 1
end = strain_len
data_B= []
data_C =[]
pro_num = 0
for prophage in coordfile_list:
    prophage = prophage.rstrip("\n")
    #deal with voerlapping prophages in previous script, originally dealt with it here, but led to BLAST score matrix alignment issues
    part_A = int(prophage.split("_")[0]) - start
    part_B = int(prophage.split("_")[1]) - int(prophage.split("_")[0])
    start = int(prophage.split("_")[1])
    data_B.append(part_A)
    data_B.append(part_B)
    data_C.append("0,0,255")
    data_C.append("255,0,0")
    pro_num = pro_num + 1
    final_prophage = prophage

if int(final_prophage.split("_")[1]) != end:
    data_B.append(end - int(final_prophage.split("_")[1]))
    data_C.append("0,0,255")

if '1' in coords_list and str(strain_len) in coords_list:
    col_num = (pro_num*2)-1
elif '1' in coords_list or str(strain_len) in coords_list:
    col_num = pro_num*2
else:
    col_num = (pro_num*2)+1

data_A = range(1,(col_num+1))
data_D = list(islice(multiletters(ascii_uppercase), col_num))

mat_line_list = [data_A, data_B, data_C, data_D]
#could use matrix but going to go with list of lists and then just have int = old_int + new
#still need to add the data data data data to data_A B C and D

for element in mat_line_list[0]:
    new_data_line = []
    new_data_line.append(element)
    new_data_line.append(data_B[(int(element)-1)])
    new_data_line.append(data_C[(int(element)-1)])
    new_data_line.append(data_D[(int(element)-1)])
    for x in range(1,(col_num+1)):
        new_data_line.append(str(0))
    mat_line_list.append(new_data_line)

#make a list of cumulative locations to know in which section any coordiate is:
y = 0
coord_sec_l = []
for element in data_B:
    coord_sec = y + int(element)
    coord_sec_l.append(coord_sec)
    y = coord_sec

mat_connect_l = []
for blast_hit in blast_hits_list:
    temp_list = [0, 0, 0]
    index_A = 0
    index_B = 0
    for coord_sec in coord_sec_l:
        if int(blast_hit[0]) < coord_sec:
            # need the +1 so that the record index is the first one where its bigger than the blast coord
            temp_list[0] = index_A + 1
        else:
            index_A = index_A + 1
        if int(blast_hit[2]) < coord_sec:
            temp_list[1] = index_B + 1
        else:
            index_B = index_B + 1
    temp_list[2] = blast_hit[4]
    mat_connect_l.append(temp_list)

for connection in mat_connect_l:
    line_num = connection[0] + 3
#need to add +3 to account for the data columns which are not yet included
    col_num = connection[1] + 3
    inter_val = int((mat_line_list[line_num])[col_num]) + int(connection[2])
    (mat_line_list[line_num])[col_num] = inter_val

output_name = "./output/" + file_name + "_circos.tab"
outfile = open(output_name, 'w')

z = 0
for line in mat_line_list:
    if z <= 3:
        new_line_l = ["data", "data", "data", "data"] + line
    else:
        new_line_l = line
    new_line_s = '\t'.join(str(element) for element in new_line_l)
    outfile.write(new_line_s + "\n")
    z = z + 1

outfile.close()
exit()
    
