#############################################################################
# - For the strains listed in the ./sequence_list.txt file cluster them     #
# based on their prophage profile. First make list of all possible prophage #
# address, then grep these level per level whilst creating a binary matrix  #
# based on whether or not a strain has a prophage at this address or not    #
# Potential issues include simplifying the grepping process so not          #
# regrepping t6.0 address all the time, and what if a strain has 2 or more  #
# prophages with a similar address easy to fix issue 1 by subdividing       #
# addresses in list and then sorting and uniquing them. to fix issue 2, what#
# if the matrix wasnt binary but frequency? could then use R dist and do    #
# hierachical and again clustering... a bit too much like a circle but could#
# work also doesnt matter simplifying address to cluster it, since if t6.0  #
# is the same all lower t should be as well.                                #
# First part of scripts creates lists of all possible addresses.This is     #
# followed by the creation of the matrix.                                   #
#############################################################################

### Module Calling ###
module add apps/gcc/R/3.3.1

### Variable Calling ###
rscript_call=Rscript
rscript=./background/scripts/ph_clust.R
tree_matrix=./temp/prophage_tree_matrix.data
formatted_matrix=./temp/formatted_prophage_tree_matrix.data
input_list=./input/sequence_list.txt
group_list=./temp/groupings

### Folder Creation ### 

### Folder Reset ###
rm $tree_matrix &> /dev/null

ls $group_list/cluster_*_list_*.txt | cut -d'.' -f2 | cut -d'/' -f4 | sort > ./temp/cluster_list.txt
printf "-" > ./temp/prophage_tree_matrix.data

for strain in `cat $input_list`
do
    printf "\t"$strain >> $tree_matrix
done

for group in `cat ./temp/cluster_list.txt`
do
    count=""
    for strain in `cat $input_list`
    do
        count=$count"\t""`grep "$strain" $group_list/$group.*txt | wc -l`"
    done
    printf "\n$group$count" >> $tree_matrix
done

awk '
{
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' $tree_matrix > $formatted_matrix

strain_count=`cat $input_list | wc -l`
pos_count=`cat $tree_matrix | wc -l`
header=$strain_count"_"$pos_count
sed -i "1 s/^.*$/$header/g" $formatted_matrix
sed -i 's/\s//g' $formatted_matrix
sed -i "s/_/ /g" $formatted_matrix

#$rscript_call $rscript ./temp/prophage_tree_matrix.data
