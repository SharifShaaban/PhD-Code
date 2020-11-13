module add apps/gcc/blast+/2.4.0
module add compilers/perl/5.18.1

length_var="500"
max_length="10000000"
blast_var="98"
# start needs to be bigger than 1 to avoid first line of blast which is whole genome vs whole genome
start_end="1500000_4500000"
mkdir ./results
rm -r ./data
rm ./output/*
#rm ./P.circos/*
#rm ./A.circos/*
rm ./temp/*
read -p "All areas of homology (A) or only Prophages (P)?" area_flag
area_flag="P"
length_var="500"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done

area_flag="A"
length_var="500"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="500"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="2400"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="5000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="10000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="98"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="100"
start_end="1500000_4500000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="98"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
length_var="15000"
blast_var="100"
start_end="2_10000000"
for fasta in ./input/*.fasta
do
    filename=`echo $fasta | cut -d'/' -f3 | cut -d'_' -f1`
    makeblastdb -dbtype nucl -in $fasta
    outfile=`echo "./output/"$filename"_v_"$filename"_"$blast_var"_"$length_var"_"$max_length"_blast_res.txt"`
    ls -l background/prophages/$filename* | cut -d'_' -f2,3 | sort -nk1,1 > ./temp/prophage_coord.txt
    blastn -db $fasta -query $fasta -outfmt 6 -perc_identity $blast_var | awk -v var="$length_var" -v var2="$max_length" '$4 > var && $4 < var2 {print}' > $outfile
    python ./background/blast_parse.py ./temp/prophage_coord.txt $outfile $length_var $area_flag $start_end
    full_len=`tail -n+2 background/genomes/$filename*.fasta | wc -c`
    new_lines=`tail -n+2 background/genomes/$filename*.fasta | wc -l`
    strain_len=`expr $full_len - $new_lines`
    python ./background/mat_gen.py $filename ./temp/prophage_coord.txt $strain_len
    perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/parse-table -conf etc/parse-table.conf -file ./output/$filename*circos.tab -segment_order=col_major,size_desc -placement_order=row,col -ribbon_variable -interpolate_type count -col_size_row -use_col_size_row -col_order_row -use_col_order_row -row_size_col -use_row_size_col -row_order_col -use_row_order_col -row_color_col -use_row_color_col -col_color_row -use_col_color_row -color_source row -transparency 1 -fade_transparency 0 -ribbon_layer_order=size_asc > parsed.txt
    cat parsed.txt | perl /home/sharif/Tools/circos-tools-0.22/tools/tableviewer/bin/make-conf -dir data
    perl /home/sharif/Tools/circos-0.69-4/bin/circos -param random_string=hxtwzsx -debug_group +io -conf etc/circos.conf
    mv ./results/*.png ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.png
    mv ./results/*.svg ./$area_flag.circos/$filename.$area_flag.$length_var.$blast_var.$start_end.circos.svg
    rm -r ./data
    rm ./parsed.txt
done
