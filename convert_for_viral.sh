#!/bin/bash

set -u

CONFIG="./config.sh"

if [ -e $CONFIG ]; then
    . "$CONFIG"
else
    echo Missing config \"$CONFIG\" ermagod!
    exit 12345
fi

export CWD="$PWD"
export STEP_SIZE=100

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

export LIST="$PRJ_DIR"/list_of_genbank_files

#find $VIRUS_DIR -iname "*genomic.gbff.gz" >> $LIST

NUM_FILES=$(lc $LIST)

echo Found \"$NUM_FILES\" files in \"$VIRUS_DIR\" to work on

JOB=$(qsub -J 1-$NUM_FILES:$STEP_SIZE -V -N beatbox -j oe -o "$STDOUT_DIR" ./parallel_power.sh)

if [ $? -eq 0 ]; then
  echo "Submitted job \"$JOB\" for you in steps of \"$STEP_SIZE.\"
  life is hard when you're a rock" 
else
  echo -e "\nError submitting job\n$JOB\n"
fi


