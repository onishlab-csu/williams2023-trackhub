#!/usr/bin/env bash
IN="L1_dissociated_cells_merged.bw L1_intestine_cells_merged.bw L1_non-intestine_cells_merged.bw L1_whole_merged.bw L3_dissociated_cells_merged.bw L3_intestine_cells_merged.bw L3_non-intestine_cells_merged.bw L3_whole_merged.bw embryo_dissociated_cells_merged.bw embryo_intestine_cells_merged.bw embryo_non-intestine_cells_merged.bw embryo_whole_merged.bw"


for bw in $IN
do
    echo $bw
    bedgraph=${bw/.bw/.bedgraph}
    chromdir=${bw/.bw/}
    if [ ! -e $bedgraph ]
    then
        echo "need to make $bedgraph"
        bigWigToBedGraph $bw $bedgraph
    else
        echo "$bedgraph READY"
    fi

    mkdir -p $chromdir
    for chrom in chrI chrII chrIII chrIV chrV chrX
    do
        bg=${bedgraph/.bedgraph/.$chrom.bedgraph}
        bww=${bg/.bedgraph/.bw}

        if [ ! -e $chromdir/$bww ]
        then
            if [ ! -e $chromdir/$bg ]
            then
                cmd="grep -w $chrom $bedgraph > $chromdir/$bg"
                echo $cmd
                time eval "$cmd"
            fi

            cmd="bedGraphToBigWig $chromdir/$bg chrom.sizes $chromdir/$bww && rm -v $chromdir/$bg"
            echo $cmd
            time eval "$cmd"
        else
            echo "$chromdir/$bww READY"
        fi
    done
    
done

