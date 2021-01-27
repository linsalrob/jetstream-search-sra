if [ -z "$1" ]; then
	echo -e "\n$0 <file to test>\nTest a file of SRA IDs to see if we have the matching fasta files.\nPrints valid IDs to STDOUT, missing files to STDERR.\n"; exit 2; fi

for SRA in $(cat $1); do
	if [ -e /nas/sra-data/fasta/current/${SRA:0:3}/${SRA:0:6}/$SRA.fasta.gz ]; then
		echo $SRA;
	else
		echo $SRA >&2;
	fi
done
