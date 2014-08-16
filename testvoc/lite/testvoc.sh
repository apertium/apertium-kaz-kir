#!/bin/bash

# A script to run the "lite" ("one-word-per-each-paradigm-") testvoc.
#
# Assumes the pair is compiled.
# Extracts lexical units from compressed text files in languages/apertium-kaz/
# tests/morphotactics/ and languages/apertium-kir/tests/morphotactics
# and passes them through the translator (=INCONSISTENCY script).
# Produces 'testvoc-summary' files using the INCONSISTENCY_SUMMARY script.
#
# TODO: Generate stats about each file (e.g. N1.txt), not just about the category (e.g. nouns).
#
# Usage: [TMPDIR=/path/to/tmpdir] ./testvoc.sh

INCONSISTENCY=../standard/./inconsistency.sh
INCONSISTENCY_SUMMARY=../standard/./inconsistency-summary.sh

if [ -z $TMPDIR ]; then
	TMPDIR="/tmp"
fi

export TMPDIR

function extract_lexical_units {
    sort -u | cut -f2 -d':' | \
    sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g'
}

#-------------------------------------------------------------------------------
# Kazakh->Kyrgyz testvoc
#-------------------------------------------------------------------------------

PARDEF_FILES=../../../../languages/apertium-kaz/tests/morphotactics/*.txt.gz

echo "==Kazakh->Kyrgyz==========================="

echo "" > $TMPDIR/kaz-kir.testvoc

for file in $PARDEF_FILES; do
    zcat $file | extract_lexical_units |
    $INCONSISTENCY kaz-kir >> $TMPDIR/kaz-kir.testvoc
done

$INCONSISTENCY_SUMMARY $TMPDIR/kaz-kir.testvoc kaz-kir

#-------------------------------------------------------------------------------
# Kyrgyz->Kazakh testvoc
#-------------------------------------------------------------------------------

# TODO
