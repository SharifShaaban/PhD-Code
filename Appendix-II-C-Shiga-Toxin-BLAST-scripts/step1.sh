#############################################################################
# - BLAST stx genes and output their prophages and then group them by       #
# subtype                                                                   #
#############################################################################

#cat ./input/sequences/*.fasta > ./input/all_genomes.fasta
#module add apps/gcc/blast+/2.4.0

#makeblastdb -dbtype nucl -in ./input/queries/stx_genes_with_flanking_regions.fasta
#blastn -db ./input/queries/stx_genes_with_flanking_regions.fasta -query ./input/all_genomes.fasta -culling_limit 1 -outfmt 6 | awk '$4 > 200 {print}' > output/stx_blast_res.txt

cat ./input/raw_prophages/*.fasta > ./input/all_prophages.fasta
blastn -db ./input/queries/stx_genes_with_flanking_regions.fasta -query ./input/all_prophages.fasta -culling_limit 1 -outfmt 6 | awk '$4 > 200 {print}' > output/stx_blast_res_prophages.txt

#makeblastdb -dbtype nucl -in ./input/queries/is_db.fasta
#blastn -db ./input/queries/is_db.fasta -query ./input/all_genomes.fasta -culling_limit 1 -qcov_hsp_perc 100 -outfmt 6 > output/is_blast_res.txt

grep "stx" output/stx_blast_res_prophages.txt | awk {'print'} | sort | uniq > output/all_stx_list.txt
grep "stx1a" output/stx_blast_res_prophages.txt | awk {'print$1'} | sort | uniq > temp/stx1a_list.txt
grep "stx2a" output/stx_blast_res_prophages.txt | awk {'print$1'} | sort | uniq > temp/stx2a_list.txt
grep "stx2c" output/stx_blast_res_prophages.txt | awk {'print$1'} | sort | uniq > temp/stx2c_list.txt
grep "stx2d" output/stx_blast_res_prophages.txt | awk {'print$1'} | sort | uniq > temp/stx2d_list.txt

rm ./output/prophage_colour_code.txt
for list in ./temp/stx*list.txt
do
    list_name=`echo $list | cut -d'_' -f1 | cut -d'/' -f3`

    if [ $list_name == "stx1a" ]
    then
        colour_code="0 255 0"
    elif [ $list_name == "stx2a" ]
    then
        colour_code="255 0 0"
    elif [ $list_name == "stx2c" ]
    then
        colour_code="0 0 255"
    else
        colour_code="120 120 120"
    fi

    mkdir ./output/$list_name
    for prophage in `cat $list | cut -d' ' -f1`
    do
        cp ../propi*/output/gbf/$prophage.gbf ./output/$list_name/
        echo -e $prophage'\t'$colour_code >> output/prophage_colour_code.txt
    done
done
