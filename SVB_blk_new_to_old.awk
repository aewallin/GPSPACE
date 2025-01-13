/^HDR NOMINAL GPS ANTENNA OFFSETS PER BLK/{blk_add=0;blk_off=3}
/^HDR NOMINAL GLONASS ANTENNA OFFSETS PER BLK/{blk_add=-14;blk_off=3}
/^HDR NOMINAL GALILEO ANTENNA OFFSETS PER BLK/{blk_add=-30;blk_off=3}
/^HDR NOMINAL BEIDOU ANTENNA OFFSETS PER BLK/{blk_add=-40;blk_off=4}

/^HDR$/||/^HDR[^ ]/||/^HDR [^12]/{print}

/^BLK /	{
	n=index($0," "$(NF-blk_off)" ")
        if( blk_add == 0 && $(NF-blk_off) >= 7 ) sub(/^BLK/,"HDR")
	printf "%-9s%2d ",substr($0,0,n),$(NF-blk_off)+blk_add
	for(n=blk_off;n;n--) printf "%-9s",$(NF-n+1)
	printf "\n"
	}

/HDR [12]/||/^GPS /||/^GLN /||/^GAL /||/^BEI /	{
        if( blk_add == 0 && substr($(18),0,4) >= 2017 ) sub(/^GPS/,"HDR")
	printf "%s %2d %s\n",substr($0,0,33),$10+blk_add,substr($0,38)
	}
