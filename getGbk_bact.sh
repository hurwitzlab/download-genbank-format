#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=2:mem=3gb
#PBS -l walltime=72:00:00
#PBS -l cput=72:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m ea
#PBS -o out
#PBS -j oe

export WD=$PBS_O_WORKDIR

cd $WD

export DIR="/rsgrps/bhurwitz/hurwitzlab/data/reference/refseq_gbff_files/bacteria"

mkdir -p $WD/out

if [ ! -d $DIR ]; then 
    mkdir -p $DIR
fi

cd $DIR

#"all_assembly_versions/" is excluded because
#we just want "latest_assembly_versions/"

#the order of rync include/exclude is so because
#1.rsync builds a list of all files with full paths
#2.rsync checks each entry against the rules from first to last
#3.if a rule applies then it puts it in the 'include' pile
#or 'exclude' pile
#4.then checks the next file in the list


#this seems to work
rsync -z --progress --prune-empty-dirs --partial -L -r \
    --exclude="all_assembly_versions/" \
    --include="*/" --include="*genomic.gbff.gz" \
    --exclude="*" \
    ftp.ncbi.nlm.nih.gov::genomes/refseq/bacteria/ ./
