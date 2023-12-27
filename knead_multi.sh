#!/bin/bash

# please enter input folder path
file=(`ls ./fastq_data/merged_fastq`)
adapter="./BGI.fa"

for files in "${file[@]}"
do
    echo $files
    kneaddata --unpaired ./fastq_data/merged_fastq/${files} \
    -db kneaddata_human_genome_bowtie2_reference_db \
    -o ./kneaddata_res \
    --trimmomatic-options ILLUMINACLIP:${adapter}:2:30:10 \
    --fastqc /tmp/FastQC \
    -t 30 
done
