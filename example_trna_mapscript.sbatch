#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=epyc-64
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=16G


# READ ME
# This script is for the first round of mapping to map chimeric reads that may contain tsRNAs
# to a custom genome containing the sequences of all mature tRNAs (from Lowe lab database).
# 'CCA' was added to the end of each of these tRNAs 


####################################################################################################
function mapping() {
	mkdir $WorkPath
	cd $WorkPath

	## STAR mapping
	$ScriptPath/STAR-2.7.9a/bin/Linux_x86_64/STAR \
	--runThreadN 8 \
	--genomeDir $StaridxPath \
	--readFilesIn $Fastq \
	--outSAMtype BAM SortedByCoordinate \
	--outFileNamePrefix $Outprefix'_' \
	--outFilterMultimapNmax 100 \
	--limitBAMsortRAM 5167980720 \
	--alignEndsType Local \
	--outFilterMismatchNmax 1 \
	--outFilterMatchNmin 15 \
	--outFilterMatchNminOverLread 0 \
	--outFilterScoreMinOverLread 0 \
	--scoreGap 0 \
	--scoreGapNoncan 0 \
	--scoreGapGCAG 0 \
	--scoreGapATAC 0 \
	--scoreGenomicLengthLog2scale -1  
	
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
