#!/usr/bin/python
# python version 2.6.6

#imports
import os
import sys

#get arguments and save them as variables
prophage_coord_file = sys.argv[1]
blast_res_file = sys.argv[2]
length_var = sys.argv[3]
area_flag = sys.argv[4]
start_end = sys.argv[5]

start = start_end.split('_')[0]
end = start_end.split('_')[1]

#not having condition_string_A as global variable to simplify awk string generation in else loop
if area_flag == "P":
    condition_string_A = '$4 >= ' + length_var + ' && ($7 >= ' + start + ' && $7 <= ' + end + ' && $8 >=' + start + ' && $8 <=' + end + '&& $9 >= ' + start + ' && $9 <= ' + end + ' && $10 >=' + start + ' && $10 <=' + end + ")"
    condition_string_B = ""
    condition_string_C = ""
    with open(prophage_coord_file) as prophage_coord:
        for line in prophage_coord:
            start = line.split('_')[0]
            end = (line.split('_')[1]).rstrip("\n")
    #        condition_string_B = (condition_string_B + '(bdstart >= ' + start + ' and bdstart <= ' + end + ' and bdend >=' + start + ' and bdend <=' + end + ")" + " or ")
    #        condition_string_C = (condition_string_C + '(bqstart >= ' + start + ' and bqstart <= ' + end + ' and bqend >=' + start + ' and bqend <=' + end + ")" + " or ")
            condition_string_B = (condition_string_B + '($7 >= ' + start + ' && $7 <= ' + end + ' && $8 >=' + start + ' && $8 <=' + end + ")" + " || ")
            condition_string_C = (condition_string_C + '($9 >= ' + start + ' && $9 <= ' + end + ' && $10 >=' + start + ' && $10 <=' + end + ")" + " || ")
    condition_string_B = condition_string_B.rstrip(" || ")
    condition_string_C = condition_string_C.rstrip(" || ")
    condition_string = condition_string_A + " && (" + condition_string_B + ") && (" + condition_string_C + ")"
    awk_string = ("awk \'{ if (" + condition_string + ") print $0; }\' " + blast_res_file)
    bash_command = awk_string + " > ./output/relevant" + blast_res_file.split("_")[2] + ".blast.txt"
    os.system(bash_command)
else:
    condition_string_A = '$4 >= ' + length_var + ' && ($7 >= ' + start + ' && $7 <= ' + end + ' && $8 >=' + start + ' && $8 <=' + end + '&& $9 >= ' + start + ' && $9 <= ' + end + ' && $10 >=' + start + ' && $10 <=' + end + ")"
    awk_string = ("awk \'{ if (" + condition_string_A + ") print $0; }\' " + blast_res_file)
    bash_command = awk_string + " > ./output/relevant" + blast_res_file.split("_")[2] + ".blast.txt"
    os.system(bash_command)
    exit()
#with open("./output/relevant" + blast_res_file.split("_")[2] + ".blast.txt") as temp_file:
#    previous_line = range(0,20)
#    for line in temp_file:
#        split_line = line.split("\t")
#        if split_line[1] == previous_line[1] and split_line[2] == previous_line[2] and split_line[3] == previous_line[3] and split_line[4] == previous_line[4] and split_line[5] == previous_line[5] and split_line[6] == previous_line[9] and split_line[7] == previous_line[8] and split_line[8] == previous_line[7] and split_line[9] == previous_line[6] and split_line[11] == previous_line[11]:
#            continue
#        else:
#            print line.rstrip("\n")
#        previous_line = split_line
exit()
