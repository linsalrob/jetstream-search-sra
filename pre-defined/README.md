# Sequence IDs in Search SRA

These are the list of Sequence Read Archive run IDs currently available in the searchSRA. If you would like to repeat a previous search, please view the history of the file and revert to a different ID list. 


- [All-SRA-metagenomes](All-SRA-metagenomes) - a complete list of all of the IDs currently available
- [All-SRA-metagenomes.excluded](All-SRA-metagenomes.excluded) -  IDs that are removed. These are typically not metagenome datasets. These files may not be available 
- [HMP](HMP) - the human microbiome project IDs. This is an intermedia data set that currently has 11,473 runs.
- [HMP.excluded](HMP.excluded) - IDs that are removed from the HMP project. These files may not be available
- [TARA](TARA) - the TARA Oceans project IDs. This is a much smaller set, and perfect for beginning searches. It currently has 249 runs.
- [TARA.excluded](TARA.excluded) - IDs that are removed from the TARA project. These files may not be available


`update_data.sh` is a simple bash script to check for the presence of fasta files corresponding to IDs. You can run that code:

```
bash update_data.sh All-SRA-metagenomes > all.have 2> all.havenot
```

Any valid ID (for which we have a fasta file) will be in `all.have`. Any invalid ID (for which we do not have a fasta file) will be in `all.havenot`.
