#!/bin/bash

cat texts/story.kaz.2.txt| apertium -d . kaz-kir > texts/story.kaz-kir.txt ;  sed 's/¶  //' texts/story.kaz-kir.txt > texts/story.kaz-kir.2.txt
wdiff texts/story.kaz-kir.2.txt texts/story.kaz-kir-postedited.2.txt | colordiff
