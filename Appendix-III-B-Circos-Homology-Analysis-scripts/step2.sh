for group in `cat ./input/group_list.txt`
do
    python ./background/sep_groups.py $group
done
