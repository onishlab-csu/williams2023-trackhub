#!/usr/bin/env bash
inputdir=$1
shortLabel="$2"
longLabel="$3"
trackname=$inputdir
maxHeightPixels="50:50:11"

indent="   "
echo "track $trackname"
echo "container multiWig"
echo "aggregate solidOverlay"
echo "type bigWig"
echo "maxHeightPixels $maxHeightPixels"
echo "shortLabel $shortLabel"
echo "longLabel $longLabel"
echo

for bw in ${inputdir}/*.bw
do
    track=${bw/.bw}
    echo -e "${indent}track $track"
    echo -e "${indent}parent $trackname"
    echo -e "${indent}bigDataUrl RNASeq/$bw"
    echo
done

