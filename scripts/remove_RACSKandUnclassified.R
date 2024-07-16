### remove GLUE sequences from the RAC-SK clade or that are unclassifieid (i.e. just classified as RABV)

library(treeio)

# import sequences
fasta=read.fasta("data/sequence_data/glue/Bolivia/Bolivia_AL_Cosmopolitan_sequences.fasta")

#import metadata
meta=read.table("data/sequence_data/glue/glue_LAC_dogRABV_metadata.txt", header=T, sep="\t")

# sequences with rac-sk or unclassified
remove=meta$sequence.sequenceID[which(meta$alignment.displayName=="RAC-SK"|meta$alignment.displayName=="Rabies Virus (RABV)")]
