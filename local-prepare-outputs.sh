#!/bin/bash

set -e

RUN_ID=$1

zip -r results . -i '*.bam' -i '*.bai'

# put the outputs under the web area
TARGET_DIR=/srv/web/results/$RUN_ID
mkdir -p $TARGET_DIR
mv results.zip $TARGET_DIR/

SIZE=`du -s --si $TARGET_DIR/results.zip | sed 's/\t.*//'`

# what was the total usage of the search?
HOURS=`condor_history -const "wf_run_id == \"$RUN_ID\"" -af CumulativeSlotTime | egrep '[0-9\.]+' | python -c 'from __future__ import division; import sys; secs = sum(float(l) for l in sys.stdin); hours = secs / 3600.0; print("%0.2f" %(hours));'`

# what is our external ip?
MY_IP=`dig +short myip.opendns.com @resolver1.opendns.com`

# create a report file to share with the portal
cat >report.txt <<EOF
results_url = http://$MY_IP/results/$RUN_ID/results.zip
results_size = $SIZE
total_compute_hours = $HOURS
EOF

# a second copy of the report for the user?
cp report.txt $TARGET_DIR/

echo "All done!"

