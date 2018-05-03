#!/bin/bash

set -e

export PATH=/usr/local/sratoolkit/current/bin:/usr/local/bowtie2/current:/usr/local/RAPSearch2/bin:/usr/local/bin:/usr/bin

REF_BASENAME=$1

bowtie2-build $REF_BASENAME.fna $REF_BASENAME

