#!/bin/bash

set -e

export PATH=/usr/local/sratoolkit/current/bin:/usr/local/bowtie2/current:/usr/local/RAPSearch2/bin:/usr/local/bin:/usr/bin

REF_BASENAME=$1
shift
SRA_IDS="$@"

# ensure the wrangler filesystem is mounted
if [ ! -e /nas/wrangler/NCBI/SRA/Downloads ]; then
    echo "ERROR: Wrangler mount is not available!" 1>&2
    exit 1
fi

{

   for SRA_ID in $SRA_IDS; do
   
        echo

        # check wrangler cache first
        WRANGLER_LOC=/nas/wrangler/NCBI/SRA/Downloads/fastq/$SRA_ID.fastq.gz
        if [ -e $WRANGLER_LOC ]; then
            SRA_SOURCE="$WRANGLER_LOC"
            echo "Will read $SRA_ID from $WRANGLER_LOC"
        else
            # not found - we should log this better
            echo "WARNING: $SRA_ID not found on Wrangler - skipping..."
            # empty outputs so that job stageout works
            touch $SRA_ID.bam $SRA_ID.bam.bai
            continue 
        fi
    
        bowtie2 -p 1 -q --no-unal -x $REF_BASENAME -U $SRA_SOURCE | samtools view -bS - | samtools sort - $SRA_ID
    
        samtools index $SRA_ID.bam

        rm -f $HOME/ncbi/public/sra/$SRA_ID.sra*

    done

} 2>&1


