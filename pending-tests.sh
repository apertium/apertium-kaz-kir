#!/bin/bash

C=2
GREP='.'
if [ $# -eq 1 ]
then
    C=$1
    GREP='WORKS'
fi

sh wiki-tests.sh Pending kaz kir update | grep -C $C "$GREP"

sh wiki-tests.sh Pending kir kaz update | grep -C $C "$GREP"

