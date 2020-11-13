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

bash_command = "mkdir ../circos_results/" + group_name
os.system(bash_command)

for member in member_list:
    bash_command = "cp ./*.circos/" + member + "*.circos.* ../circos_results/" + group_name
    os.system(bash_command)

bash_command = "mkdir ../circos_results/" + group_name + "/A"
os.system(bash_command)
bash_command = "mv ../circos_results/" + group_name + "/*.A.circos* ../circos_results/" + group_name + "/A"
os.system(bash_command)
bash_command = "mkdir ../circos_results/" + group_name + "/P"
os.system(bash_command)
bash_command = "mv ../circos_results/" + group_name + "/*.P.circos* ../circos_results/" + group_name + "/P"
os.system(bash_command)
exit()
