
date

#please enter input path
fastq=(`ls ./kneaddata_res/*kneaddata.fastq`)

humann_config --update database_folders nucleotide db/full_chocophlan.v201901_v31/
humann_config --update database_folders protein db/uniref90/
humann_config --update database_folders utility_mapping db/full_mapping_v201901b/

for input in "${fastq[@]}"
do
    echo $input
    time humann -i $input -o result 
done

date