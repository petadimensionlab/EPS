
Source code of shotgun metagenomic data analysis by HUMAnN3.0 for the manuscript entitled Sucrose-preferring gut microbes prevent host obesity by producing exopolysaccharides


Set the CPU, memory, and disk limit used in Docker.

# Build and run the docker image for bbtools and　knead
docker image build -t eps/knead:0.12.0 knead_docker/
docker run --name knead -itv $(pwd):/tmp eps/knead:0.12.0 

# Execute bbtools to merge pair-end sequences.

bash merge.sh;


# Execute knead to remove host genome.

bash knead_multi.sh;

# Build and run the docker image for humann3 
docker image build -t eps/humann:3.8.4.0.4 .
docker run --name eps -itv $(pwd):/tmp eps/humann:3.8.4.0.4

# For apple silicon
docker image build -t eps/humann:3.8.4.0.4 appleSL/
docker run --platform=linux/x86_64 --name eps -itv $(pwd):/tmp eps/humann:3.8.4.0.4

# Overwrite metaphlan database 
rm -r /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases
cp -r metaphlan_databases/ /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases
# Check if there are mpa_latest, 8 files named "mpavOct22~~", and readme
ls /usr/local/lib/python3.8/site-packages/metaphlan/metaphlan_databases

# Set the number of cores to be used on docker
humann_config --update run_modes threads 12
humann_config --update run_modes verbose True

# test humann
humann_test

# Run humann demo
### This takes a long time if metaphlan db is not overwritten
humann -i demo.fastq -o sample_results;


# Update the reference database
humann_config --update database_folders nucleotide db/full_chocophlan.v201901_v31/
humann_config --update database_folders protein db/uniref90/
humann_config --update database_folders utility_mapping db/full_mapping_v201901b/


# Run humann3 for one sample
humann -i [path_of_sample.fastq] -o result 

# Run humann3 for all samples in a certain folder.
bash humann_multi.sh;

# To exit the Docker 
exit

# To access to the docker again, 
docker start eps
docker container exec -it eps bash



