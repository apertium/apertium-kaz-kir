#!/bin/bash

grep '<e' ../apertium-kaz-kir.kaz-kir.dix | grep -v 'i="yes"' | wc -l
