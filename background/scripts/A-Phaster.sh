#############################################################################
# - For the strains listed in the ./sequence_list.txt file send sequence    #
# to the PHASTER server, then from the obtained file extract the URL for the#
# summary of the results                                                    #
# - Until the file is not of size 0 sleep for 5 minutes, then try accessing #
# the result URL again (until the result URL is populated by PHASTER it will#
# result in no file, thus the loop will check for results every 5 minutes.  #
# - Awk and grep are used to extract the coordinates of the PHAST results.  #
#############################################################################

### Variable Calling ###
phast_path=./temp/phast_extrac_res
phaster_api=http://phaster.ca/phaster_api

### Folder Creation ###
mkdir ./temp &> /dev/null
mkdir ./input &> /dev/null
mkdir ./input/sequences &> /dev/null
mkdir ./output &> /dev/null
mkdir $phast_path &> /dev/null
mkdir $phast_path/html_out &> /dev/null
mkdir $phast_path/summary_out &> /dev/null
mkdir $phast_path/temp &> /dev/null

for strain_name in `cat ./input/sequence_list.txt`
do
#    wget --post-file ./input/sequences/$strain_name* $phaster_api -O $phast_path/html_out/$strain_name.phast_out.html
#    url_code=`cat $phast_path/html_out/$strain_name.phast_out.html | cut -d'"' -f4`
#    flag=0
#    until [[ $flag -eq 1 ]];
#    do
#        sleep 5
#        echo $"$phaster_api?acc=$url_code"
#        wget "$phaster_api?acc=$url_code" -O $phast_path/summary_out/$strain_name.summary.txt
#        flag=1
#        flag=`grep -c "Complete" $phast_path/summary_out/$strain_name.summary.txt`
#    done

    temp_string=`cat $phast_path/summary_out/$strain_name.summary.txt`
    echo -e $temp_string | awk '{print $5}' | grep "\-" > $phast_path/temp/$strain_name.temp
done
