#############################################################################
# - Create a GBK file format with the prophages as the key feature rather   #
# than CDSs or genomes                                                      #
#############################################################################

module add apps/gcc/EMBOSS/6.6.0

for genome in ./input/genomes/*.fasta
do
    seqret -sequence $genome -outseq ./temp/temp.gbk -osformat2 genbank
    genome_name=`echo $genome | cut -d'/' -f4 | cut -d'_' -f1`
    ls -l ./input/prophages/$genome_name* | awk '{print $9}' | cut -d'_' -f2 |sort -n > ./temp/temp_prophage_sorted_list.txt
    for line in `cat ./temp/temp_prophage_sorted_list.txt`
    do
        ls ./input/prophages/$genome_name*$line* >> ./temp/prophage_sorted_list.txt
    done
    head -1 ./temp/temp.gbk > ./output/$genome_name.gbk
    length=`head -1 ./temp/temp.gbk | awk '{print $3}'`
    printf "FEATURES             Location/Qualifiers\n" >> ./output/$genome_name.gbk
    printf "     source          1.."$length"\n" >> ./output/$genome_name.gbk
    for line in `cat ./temp/prophage_sorted_list.txt`
    do
        prophage_name=`printf $line | cut -d'/' -f4 | cut -d'.' -f1`
        colour_code=`grep "$prophage_name" ./input/prophage_colour_code.txt | cut -d$'\t' -f 2`
        start=`printf $line | cut -d'/' -f4 | cut -d'_' -f2`
        end=`printf $line | cut -d'/' -f4 | cut -d'_' -f3`
        coor=$start".."$end
        if [[ "$colour_code" == "" ]]; then
            colour_code="255 255 153"
        fi
        printf "     Prophage        "$coor"\n" >> ./output/$genome_name.gbk
        printf "                     /colour=$colour_code\n" >> ./output/$genome_name.gbk
    done
    genome_name2=`echo $genome_name"_c"`
    tail -n +2 ./temp/temp.gbk >> ./output/$genome_name.gbk
    rm ./temp/*
done

for file in ./output/*.gbk
do
    sed -i '/DEFINITION*/d' $file
done

#module add compilers/python/2.7.9_shared
#module add apps/gcc/blast+/2.4.0
#python_call=python
#easyfig_path=/groups2/gally_grp/fsa_project/sharif/tools/Easyfig_CL_2.1.py

#$python_call $easyfig_path -f Prophage [rect] -svg -o ./output/whole_genome_prophage_map.svg ./output/*.gbk

#python /groups2/gally_grp/fsa_project/sharif/tools/Easyfig_CL_2.1.py -f1 T -f2 1000 -o ./output/trial_isolation.svg -blast_height 250 -width 5000 -f Prophage 255 235 205 rect -f XbaI 211 211 211 pointer -blast_col 135 206 250 0 0 128 -blast_col_inv 233 150 122 255 0 0 ./output/Z1615.gbk ./output/9000.gbk ./output/Z1766.gbk ./output/Z1767.gbk ./output/Z1768.gbk ./output/Z1769.gbk

