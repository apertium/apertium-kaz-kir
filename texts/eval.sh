#!/bin/bash

TEXT=$1;

cat texts/$TEXT.kaz.txt| apertium -d . kaz-kir > texts/$TEXT.kaz-kir.txt ;  sed 's/¶  //' texts/$TEXT.kaz-kir.txt > texts/$TEXT.kaz-kir.2.txt

wdiff texts/$TEXT.kaz-kir.2.txt texts/$TEXT.kaz-kir-postedited.2.txt | colordiff

../../trunk/apertium-eval-translator/apertium-eval-translator-line.pl -t texts/$TEXT.kaz-kir.2.txt -r texts/$TEXT.kaz-kir-postedited.2.txt


