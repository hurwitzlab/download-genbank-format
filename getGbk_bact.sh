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

#this seems to work
rsync -z --progress --prune-empty-dirs --partial \
    -L -r --include="*/" --exclude="*" --include="*.genomic.gbff.gz" \
    ftp.ncbi.nlm.nih.gov::genomes/refseq/bacteria/ ./
