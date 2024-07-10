#! /bin/bash

#changes fasta header to match filename
for i in $(find . -name '*.fasta'); do
new=$(basename $i)
new=${new%.consensus.fasta}
perl -i -pe "s/.*/>$new/ if $.==1" $i
done
