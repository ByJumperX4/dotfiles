#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#28333b/g' \
         -e 's/rgb(100%,100%,100%)/#c9c4b3/g' \
    -e 's/rgb(50%,0%,0%)/#394650/g' \
     -e 's/rgb(0%,50%,0%)/#ff6600/g' \
 -e 's/rgb(0%,50.196078%,0%)/#ff6600/g' \
     -e 's/rgb(50%,0%,50%)/#394650/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#394650/g' \
     -e 's/rgb(0%,0%,50%)/#c9c4b3/g' \
	$@