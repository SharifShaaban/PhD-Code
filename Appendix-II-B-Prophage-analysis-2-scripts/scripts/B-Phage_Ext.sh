#############################################################################
# - For the strains listed in the ./sequence_list.txt file run the python   #
# scripts which will process the PHASTER results.                           #
# - The python script reworks the coordinates to merge prophages which are  #
# within 4000 bps of each other as these could be due to IS elements.       #
# - The results of the python script are then formatted, sorted and uniqued #
# based on the start coordinate as the script duplicates coordinates when   #
# merging prophages.                                                        #
# - The regions are then extracted using EMBOSS extractseq tool.            #
#############################################################################

### Module Calling ###
module add apps/gcc/EMBOSS/6.1.0

### Variable Calling ###
phast_path=./temp/phast_extrac_res
raw_path=./temp/raw_res
emboss_call=extractseq
raw_p_path=./temp/raw_prophages

### Folder Creation ### 
mkdir $raw_path &> /dev/null
mkdir $phast_path/temp &> /dev/null
mkdir $raw_p_path &> /dev/null

### Folder Reset ###
#rm $raw_p_path/* &> /dev/null

for strain_name in `cat ./input/sequence_list.txt`
do
    strain_name2=`echo $strain_name | cut -d'_' -f1`
    if [ $(cat $phast_path/temp/$strain_name* | wc -l) -lt 1 ];then
        echo "No prophages found in $strain_name"
    else
        python ./background/scripts/phast_res_proc.py $phast_path/temp/$strain_name.temp
        cat $phast_path/temp/regions_out_temp.txt | sort -t$':' -nk1,1 -rnk2,2 | sort -ru -nk1,1 | sort -t$':' -nk1,1 > $phast_path/temp/regions_out.txt

        for region in `cat $phast_path/temp/regions_out.txt`
        do
            $emboss_call ./input/sequences/$strain_name*.fasta $raw_path/$strain_name2.$region.fasta -regions "$region"
        done
    fi

done

#############################################################################
# - For all the prophage regions, a temp file is create with the length of  #
# the prophage in the name as well as _ rather than . separating each part  #
# of the name.                                                              #
#############################################################################

for file in $raw_path/*.fasta
do
    filename=`echo $file | cut -d"/" -f4`
    strain=`echo $filename | cut -d"." -f1`
    regions=`echo $filename | cut -d"." -f2`
    region_a=`echo $regions | cut -d":" -f1`
    region_b=`echo $regions | cut -d":" -f2`
    length=`echo $(($region_b-$region_a))`
    new_filename=$strain'_'$region_a'_'$region_b'_'$length'.tempfasta'
    cp $file $raw_p_path/$new_filename
done

rm -r $raw_path

#############################################################################
# - For these previous create files changed the first line to a fasta header#
# which is identical to the filename, then remove the temp files.           #
#############################################################################

for file in $raw_p_path/*.tempfasta
do
    filename=`echo $file | cut -d"/" -f4 | cut -d"." -f1`
    first_line='>'$filename
    new_filename=$filename'.fasta'
    sed "1s/.*/$first_line/" $file > $raw_p_path/$new_filename
done

rm $raw_p_path/*temp*
