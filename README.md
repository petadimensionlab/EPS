
Source code of shotgun metagenomic data analysis for the manuscript entitled Sucrose-preferring gut microbes prevent host obesity by producing exopolysaccharides


Set the CPU, memory and disk limit used in Docker.

# Build and run the docker image for bbtools and　knead
docker image build -t eps/knead:0.12.0 knead_docker/
docker run --name knead -itv $(pwd):/tmp eps/knead:0.12.0 

# Execute bbtools to merge pair-end sequences.
date;
time bash merge.sh;
date

# Execute knead to remove host genome.
date;
time bash knead_multi.sh;
date


# Build and run the docker image for humann3 
docker image build -t eps/humann:3.8.4.0.4 .
docker run --name eps -itv $(pwd):/tmp eps/humann:3.8.4.0.4

# For apple silicon, the below
#docker image build -t eps/humann:3.8.4.0.4 appleSL/
#docker run --platform=linux/x86_64 --name eps -itv $(pwd):/tmp eps/humann:3.8.4.0.4


# Overwrite metaphlan database 
rm -r /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases
cp -r metaphlan_databases/ /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases
# Check if there are mpa_latest, 8 files named "mpavOct22~~", and readme
ls /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases

# Set the number of cores to be used on docker
humann_config --update run_modes threads 12
humann_config --update run_modes verbose True

# test humann
time humann_test

# Run humann demo
### This takes a long time if metaphlan db is not overwritten
date;
time humann -i demo.fastq -o sample_results;
date

# Update the reference database
humann_config --update database_folders nucleotide db/full_chocophlan.v201901_v31/
humann_config --update database_folders protein db/uniref90/
humann_config --update database_folders utility_mapping db/full_mapping_v201901b/


# Run humann3 for one sample
#date;
#time humann -i [path_of_sample.fastq] -o result 
#date

# Run humann3 for all samples in a certain folder.
date;
time bash humann_multi.sh;
date

# To exit the Docker 
#exit
# To access to the docker again, 
#docker start eps
#docker container exec -it eps bash



