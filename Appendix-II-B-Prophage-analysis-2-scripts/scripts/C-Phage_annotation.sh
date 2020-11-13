#############################################################################
# - Need to add module and export Path for Prokka to work on server.        #
# - For each prophage annotate using the Prokka E. coli database and the    #
# faa file given (obtained from another annotation pipeline.                #
# - Copy all gbf files to separate folder.                                  #
#############################################################################

### Module Calling ###
#module add compilers/perl/5.18.1
#module add compilers/perl/5.14.2
#module add apps/gcc/blast+/2.4.0

### Path Setting ###
#export PATH=$PATH:/usr/local/shared_bin/blast+/blast+-2.2.25/es5-64/bin/:/mnt/ris-fas1a/linux_groups2/gally_grp/fsa_project/sharif/tools/hmmer-3.1b2-linux-intel-x86_64:/groups/microbial_bioinf_grp/rnammer/:/mnt/ris-fas1a/linux_groups2/gally_grp/fsa_project/sharif/tools/
#export PERL5LIB=/groups/microbial_bioinf_grp/perl/
#export PERL5LIB=/mnt/ris-fas1a/linux_groups2/gally_grp/fsa_project/sharif/tools/prokka/perl5/

### Variable Calling ###
prokka_call=prokka
python_call=python
makeblast_call=makeblastdb
blastn_call=blastn
raw_p_path=./temp/raw_prophages
annp_path=./temp/annotated_prophages
anno_path=./temp/annot_groups
isbl_path=./temp/is_blast_res
gbf_path=./output/gbf

### Folder Creation ###
mkdir $annp_path &> /dev/null
mkdir ./temp/temp_gbf &> /dev/null
mkdir ./temp/gff &> /dev/null
mkdir ./output/gbf &> /dev/null
mkdir $anno_path &> /dev/null
mkdir $isbl_path &> /dev/null

### Folder Reset ###
#rm -r $annp_path/*
#rm ./temp/temp_gbf/*
#rm ./temp/gff/*
#rm $isbl_path/* &> /dev/null

for file in $raw_p_path/*.fasta
do
    filename=`echo $file| cut -d'/' -f 4`
    foldername=`echo $filename| cut -d'.' -f 1`
    $prokka_call --proteins ./background/panprophage.faa --genus Escherichia --species coli --usegenus --rfam --prefix $foldername --outdir $annp_path/$foldername $file --force
done

find $annp_path/*/ -name "*.gbf" -exec cp {} ./temp/temp_gbf/ \;
find $annp_path/*/ -name "*.gff" -exec cp {} ./temp/gff/ \;

#############################################################################
# - Call python script to add colour flag to gbf file and move them to gbk  #
# folder.                                                                   #
# - Sort and unique temp file to summarise all the products falling in each #
# functional group observed.                                                #
#############################################################################

$python_call ./background/scripts/gbf_colours.py

for file in $anno_path/*.tmp
do
    filename=`echo $file| cut -d'/' -f 4`
    name=`echo $filename| cut -d'.' -f 1`
    fin_name="$anno_path/"$name".txt"
    cat $file | sort | uniq > $fin_name
    rm $file
done

#############################################################################
# - Look for IS elements in prophages using BLAST. Sort hits to have most   #
# likely and reliable IS hits.                                              #
#############################################################################

for prophage in $raw_p_path/*.fasta
do
    filename=`echo $prophage | cut -d"/" -f4 | cut -d"." -f1`
    result_file="$isbl_path/"$filename"_is_blast.txt"
    $makeblast_call -dbtype nucl -in $prophage
    $blastn_call -db $prophage -query ./background/is_db.fasta -evalue 1e-100 -best_hit_score_edge 0.0001 -best_hit_overhang 0.25 -outfmt 6 | awk '$4>700' | sort -nrk12,12 | sort -u -k9,9 | sort -nrk12,12 | sort -u -k10,10 | sort -nk9,9 > $result_file
done

#############################################################################
# - Format the BLAST result file, to create a colour flag for IS elements   #
# containing its coordinates and adding it to the prophage GBF files.       #
#############################################################################

rm $raw_p_path/*.fasta.n* &> /dev/null
find $isbl_path/ -empty -type f -delete

for file in $isbl_path/*blast.txt
do
    sed -i "s/\t/=/g" $file
done

for file in $gbf_path/*.gbf
do
    rm ./temp_p_file.txt &> /dev/null

    g_name=`echo $file| cut -d'/' -f 4 | cut -d'_' -f 1`
    p_start=`echo $file| cut -d'/' -f 4 | cut -d'_' -f 2`
    p_end=`echo $file| cut -d'/' -f 4 | cut -d'_' -f 3`
   
    for is_line in `cat $isbl_path/$g_name*$p_end*"is_blast.txt"`
    do
        is_coo_a=`echo $is_line | cut -d'=' -f 9`
        is_coo_b=`echo $is_line | cut -d'=' -f 10`

        if [ $is_coo_a -gt $is_coo_b ]; then
            is_start=$is_coo_b
            is_end=$is_coo_a
        else
            is_start=$is_coo_a
            is_end=$is_coo_b
        fi

        printf "     IS              "$is_start".."$is_end"\n" >> temp_p_file.txt
        printf "                     /colour=255 255 0\n" >> temp_p_file.txt

    done
    
    declare -i line_number=`grep -n "ORIGIN" $file | cut -d":" -f 1`
    declare -i line_number2=$line_number-1 
    head -$line_number2 $file > ./new_file.tmp
    cat temp_p_file.txt >> ./new_file.tmp
    tail -n +$line_number $file >> ./new_file.tmp
    mv ./new_file.tmp $file
done

rm ./temp_p_file.txt &> /dev/null

for file in $isbl_path/*blast.txt
do
    sed -i "s/=/\\t/g" $file
done
