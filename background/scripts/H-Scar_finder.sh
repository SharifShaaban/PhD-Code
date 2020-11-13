### Module Calling ###
module add compilers/perl/5.18.1
module add apps/gcc/blast+/2.4.0

### Path Setting ###
export PATH=$PATH:/groups/microbial_bioinf_grp/:/usr/local/shared_bin/blast+/blast+-2.2.25/es5-64/bin/:/groups/microbial_bioinf_grp/hmmer3/:/groups/microbial_bioinf_grp/rnammer/
export PERL5LIB=/groups/microbial_bioinf_grp/perl/

### Variable Calling ###
prokka_call=/usr/local/shared_bin/prokka/prokka-1.5.2/bin/prokka
python_call=python
makeblast_call=makeblastdb
blastn_call=blastn
raw_p_path=./temp/raw_prophages
annp_path=./temp/annotated_prophages
anno_path=./temp/annot_groups
isbl_path=./temp/is_blast_res
gbf_path=./output/gbf

### Folder Creation ###
mkdir ./output/scarring_regions &> /dev/null
mkdir ./output/annotated_genomes &> /dev/null

### Folder Reset ###
rm ./temp/gene_locations.txt &> /dev/null
rm ./temp/strain_scar_bin_location.txt &> /dev/null
rm ./temp/strain_binary_gene_scar.bin &> /dev/null
rm ./output/scarring_regions/*.txt &> /dev/null
# rm -r ./output/annotated_genomes/*

for strain in `cat ./input/sequence_list.txt`
do

    #$prokka_call --proteins ./background/panprophage.faa --genus Escherichia --species coli --usegenus --rfam --prefix $strain --outdir ./output/annotated_genomes/$strain.PROKKA  ./input/sequences/$strain*.fasta
    grep "CDS" ./output/annotated_genomes/$strain.PROKKA/*.gff | awk '{ print $4"_"$5 }' > ./temp/gene_locations.txt
    unset array
    array=()
    gene_counter=0

    for gene in `cat ./temp/gene_locations.txt`
    do
        start=`echo $gene | cut -d'_' -f1`
        end=`echo $gene | cut -d'_' -f2`

        if [ $(($end - $start)) -lt 300 ]; then
            array+=("$gene_counter")
            gene_counter=$(($gene_counter+1))
        else
            gene_counter=$(($gene_counter+1))
        fi

    done

    # had to do loop this way to account for array starting at 0 and that the loop checks for a total of 5 therefore itself and the 4 in front
    for i in `seq 0 $((${#array[@]}-1-4))`
    do

        if [ $((${array[$i+4]} - ${array[$i]})) -lt 10 ]; then
            echo "     Scar            "`sed "${array[$i]}q;d" ./temp/gene_locations.txt | sed "s/_/../g"` >> ./output/scarring_regions/$strain.txt
        fi

    done

done
