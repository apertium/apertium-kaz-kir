#!/bin/bash

#assuming that you have the whole apertium tree in your source dir. and you are in kaz-kir directory

python3 ../../trunk/apertium-tools/trim-lexc.py apertium-kaz-kir.kaz-kir.dix ../apertium-kir/apertium-kir.kir.lexc ../apertium-kaz/apertium-kaz.kaz.lexc

cp /tmp/apertium-kaz.kaz.lexc.trimmed apertium-kaz-kir.kaz.lexc
cp /tmp/apertium-kir.kir.lexc.trimmed apertium-kaz-kir.kir.lexc

cp ../apertium-kaz/apertium-kaz.kaz.twol apertium-kaz-kir.kaz.twol
cp ../apertium-kaz/apertium-kaz.kaz.rlx apertium-kaz-kir.kaz-kir.rlx

cp ../apertium-kir/apertium-kir.kir.twol apertium-kaz-kir.kir.twol
cp ../apertium-kir/apertium-kir.kir.rlx apertium-kaz-kir.kir-kaz.rlx

exit 0


