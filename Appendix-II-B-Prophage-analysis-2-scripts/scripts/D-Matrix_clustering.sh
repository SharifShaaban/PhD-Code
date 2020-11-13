#############################################################################
# - Run Roary and move files to relevant folders                            #
# - Need to split Roary paralogs (-s) due to IS element repeat              #
#############################################################################

### Module Calling ###
#module add apps/gcc/roary/3.6.0
#module add apps/gcc/R/3.3.1
#module remove apps/gcc/blast+/2.4.0
#module add apps/gcc/blast+/2.4.0

### Variable Calling ###
rscript_call=Rscript
group_path=./temp/groupings
script_path=./background/scripts

### Folder Creation ###
mkdir ./temp/pangenome_matrix_bin/ &> /dev/null
mkdir ./output/pangenome_trees/ &> /dev/null
mkdir $group_path &> /dev/null
mkdir ./temp/members_dist_lst &> /dev/null
mkdir ./temp/group_lst &> /dev/null

### Folder Reset ###
rm -r $group_path/* &> /dev/null
rm ./temp/group_lst*.txt &> /dev/null
rm ./temp/members_dist_lst/* &> /dev/null
rm ./temp/group_lst/* &> /dev/null
rm ./temp/prophage_zip_code.ssv &> /dev/null
rm -r ./temp/roary_output/

roary -p 8 -s -f ./temp/roary_output/ -i 95 ./temp/gff/*.gff

cp ./temp/roary_output/gene_presence_absence.Rtab ./temp/pangenome_matrix_bin/
cp ./temp/roary_output/*newick ./output/pangenome_trees/

#############################################################################
# - The groupings R script is called to do hierchichal clustering of the    #
# prophages at different Eucledian distance thresholds.                     #
# - For each clusters at each of these thresholds a folder is made and      # 
# populated with the gbf files relevant to that cluster. A list is made for #
# each thresholds which shows the prophage members.                         #
# - The files are moved to the respective folders.                          #
#############################################################################

$rscript_call $script_path/h_clust.R ./temp/pangenome_matrix_bin/*.Rtab

for dist in `cat ./input/dist_list.txt`
do
 
    declare -i x=0

    for file in $group_path/*_$dist.txt
    do
        sed -i "1d" $file
        sed -i "s/\s//g" $file
        sed -i "s/^X//g" $file
        filename=`echo $file| cut -d'/' -f 4`
        name=`echo $filename| sed -e 's/\(.txt\)*$//g'`
        mkdir $group_path/$name
        x=$x+1

        for prophage in `cat $file`
        do
            cp ./output/gbf/$prophage* $group_path/$name/
        done

    done

    cd $group_path/
    ls -d *_$dist/ > ../group_list_$dist.txt
    cd ../../
    rm ./member_dist_list$dist.txt &> /dev/null

    for folder in `cat ./temp/group_list_$dist.txt`
    do
        folder_number=`echo $folder | cut -d'_' -f 2`
        printf "\n"$folder"\n" >> ./member_dist_list$dist.txt
        find ./temp/groupings/$folder/ -type f -printf "%f $folder_number\n" >> ./member_dist_list$dist.txt
    done

done

mv ./member_dist_list* ./temp/members_dist_lst/
mv ./temp/group_list_*.txt ./temp/group_lst/


#############################################################################
# - The cluster identfier for each prophage at each distance threshold is   #
# extracted and then they are all put together in one string to create the  #
# prophage code (temp version called prophage zip code).                    #
#############################################################################

for file in ./temp/temp_gbf/*
do
    filename=`echo $file | cut -d'/' -f 4`
    zipcode="$zipcode `grep "$filename" ./temp/members_dist_lst/member_dist_list6.txt | cut -d' ' -f 2`"
    zipcode="$zipcode `grep "$filename" ./temp/members_dist_lst/member_dist_list4.5.txt | cut -d' ' -f 2`"
    zipcode="$zipcode `grep "$filename" ./temp/members_dist_lst/member_dist_list3.txt | cut -d' ' -f 2`"
    zipcode="$zipcode `grep "$filename" ./temp/members_dist_lst/member_dist_list1.5.txt | cut -d' ' -f 2`"
    zipcode="$zipcode `grep "$filename" ./temp/members_dist_lst/member_dist_list0.txt | cut -d' ' -f 2`" 
    echo $filename""$zipcode >> ./temp/prophage_zip_code.ssv
    zipcode=""
done

sed -i "s/.gbf//g" ./temp/prophage_zip_code.ssv
echo "Name t6.0 t4.5 t3.0 t1.5 t0" > ./output/prophage_code.tab
cat ./temp/prophage_zip_code.ssv >> ./output/prophage_code.tab
sed -i "s/\s/\t/g" ./output/prophage_code.tab
rm ./temp/prophage_zip_code.ssv

for file in ./output/gbf/*.gbf
do
    name=`echo $file | cut -d'/' -f4 | cut -d'.' -f1`
    name=`echo "./output/gbf/"$name".gbk"`
    cp $file $name
done