#############################################################################
# - get groups of sequences in different folders rather than manually sort  #
#############################################################################

for group in `cat ./input/group_list.txt`
do
    python ./background/scripts/sep_groups.py $group
done
