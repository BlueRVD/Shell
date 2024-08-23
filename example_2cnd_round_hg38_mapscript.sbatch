#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=epyc-64
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=16G


# This script is for the 2cnd round of mapping to the hg38 genome after filtering the inital FASTQ
# file is filtered using hits from the first round of mapping to the custom tRNA database. This round
# of mapping should be done using the hg38 genome with the tRNA locations masked (this file provided in the
# files section of my github).


####################################################################################################
function mapping() {
	mkdir $WorkPath
	cd $WorkPath

	## STAR mapping
	$ScriptPath/STAR-2.7.9a/bin/Linux_x86_64/STAR \
	--runThreadN 8 \
	--runMode alignReads \
	--genomeDir $StaridxPath \
	--readFilesIn $Fastq \
	--outFileNamePrefix $Outprefix'_' \
	--genomeLoad NoSharedMemory \
	--outReadsUnmapped Fastx \
	--outFilterMultimapNmax 5 \
	--outFilterScoreMinOverLread 0 \
	--outFilterMismatchNmax 1 \
	--outFilterMatchNminOverLread 0 \
	--outFilterMatchNmin 15 \
	--outSAMattributes All \
	--outSAMtype BAM SortedByCoordinate \
	--alignIntronMin 1 \
	--scoreGap 0 \
	--scoreGapNoncan 0 \
	--scoreGapGCAG 0 \
	--scoreGapATAC 0 \
	--scoreGenomicLengthLog2scale -1 \
 
}

####################################################################################################
ScriptPath=
StaridxPath=
####################################################################################################
WorkPath=
Fastq=
Outprefix=
mapping
####################################################################################################
