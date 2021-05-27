#!/bin/bash

# See https://wiki.apertium.org/wiki/Corpus_test
#
# To make 'original' translation, type this
#make && cat corpa/kaz.crp.txt | apertium -d . kaz-tat > corpa/origina_traduko.txt &&

cat corpa/corpus.kaz.txt | apertium -d . kaz-tat > corpa/nova_traduko.txt &&

#diff -w corpa/origina_traduko.txt corpa/nova_traduko.txt | grep '^[<>]' > /tmp/crpdiff.txt &&
#  for i in `cut -c3-8 /tmp/crpdiff.txt | sort -un`; do
#    echo  --- $i ---; grep "^ *$i\." corpa/kaz.crp.txt; grep "^. *$i\." /tmp/crpdiff.txt;
#  done | less

diff -U0 corpa/origina_traduko.txt corpa/nova_traduko.txt | dwdiff -c --diff-input | more
