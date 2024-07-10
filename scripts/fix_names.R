## sequence data
library(seqinr)
library(ggtree)
library(Biostrings)
library(stringr)
library(BactDating)
library(ape)
library(castor)

# read in data from aqp12,13 and 14 (12 &13 are masked), plus illumina seq
string=readDNAStringSet("processed/multifasta/unaligned/analysis_seq.fasta")
lengths=str_count(as.character(string), "A|T|C|G")
cov=lengths/11923*100
# remove anything with less than 50% coverage
string=string[cov>50]
lengths=lengths[cov>50]
seq_data=data.frame(names=names(string), seq.length=lengths, run_id=NA)

seq_data$names=gsub("-","_",seq_data$names)
seq_data$names=gsub("/","",seq_data$names)
seq_data$names=gsub("\\..*$","",seq_data$names)


# nanopore seqs
# Find indices of file names not containing "ivar"
nano_seqs <- grep("ivar|per", seq_data$name, invert=T, ignore.case = T)

# Update file names at those indices
seq_data$name[nano_seqs] <- paste(sapply(strsplit(seq_data$name[nano_seqs], "_"), `[`, 1),
                                      sapply(strsplit(seq_data$name[nano_seqs], "_"), `[`, 2),
                                       sapply(strsplit(seq_data$name[nano_seqs], "_"), `[`, 3),
                                        sep = "_")

# fix names
# illumina seqs
# Find indices of file names containing "ivar"
illumina_seqs <- grep("ivar", seq_data$name)

# Update file names at those indices
seq_data$name[illumina_seqs] <- paste(sapply(strsplit(seq_data$name[illumina_seqs], "_"), `[`, 2),
                                sapply(strsplit(seq_data$name[illumina_seqs], "_"), `[`, 3),
                                "illumina",
                                sep = "_")
# metagenomic ones
# Find indices of file names containing "ivar"
meta_seqs <- grep("per", seq_data$name, ignore.case = T)

# Update file names at those indices
seq_data$name[meta_seqs] <- paste(sapply(strsplit(seq_data$name[meta_seqs], "_"), `[`, 1),
                                      "meta-illumina",
                                      sep = "_")

names(string)=seq_data$name
writeXStringSet(string, "processed/multifasta/unaligned/analysis_seq_renamed.fasta")

