#!/bin/bash

C=2
GREP='.'
if [ $# -eq 1 ]
then
    C=$1
    GREP='WORKS'
fi

sh wiki-tests.sh Regression kaz tat update | grep -C $C "$GREP"

sh wiki-tests.sh Regression tat kaz update | grep -C $C "$GREP"

