#!/usr/bin/python
# python version 2.6.6

#imports
import os
import sys

#get arguments and save them as variables
group = sys.argv[1]

group_list = group.split('_')

member_list = group_list[1:]
group_name = group_list[0]

bash_command = "mkdir ../whole_genome_gbks/" + group_name
os.system(bash_command)

for member in member_list:
    bash_command = "cp ./stx_coloured_output/" + member + "*.gbk ../whole_genome_gbks/" + group_name
    os.system(bash_command)
exit()
