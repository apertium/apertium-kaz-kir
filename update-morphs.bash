#!/bin/bash

#assuming that you have the whole apertium tree in your source dir. and you are in kaz-kir directory

python3 ../../trunk/apertium-tools/trim-lexc.py apertium-kaz-kir.kaz-kir.dix ../apertium-kaz/apertium-kaz.kaz.lexc ../apertium-kir/apertium-kir.kir.lexc

cp /tmp/apertium-kaz.kaz.lexc.trimmed apertium-kaz-kir.kaz.lexc
cp /tmp/apertium-kir.kir.lexc.trimmed apertium-kaz-kir.kir.lexc

DIFF=$(diff ../apertium-kaz/apertium-kaz.kaz.twol apertium-kaz-kir.kaz.twol)
if [ "$DIFF" != "" ]; then
	cp ../apertium-kaz/apertium-kaz.kaz.twol apertium-kaz-kir.kaz.twol
fi;
cp ../apertium-kaz/apertium-kaz.kaz.rlx apertium-kaz-kir.kaz-kir.rlx

DIFF=$(diff ../apertium-kir/apertium-kir.kir.twol apertium-kaz-kir.kir.twol)
if [ "$DIFF" != "" ]; then
	cp ../apertium-kir/apertium-kir.kir.twol apertium-kaz-kir.kir.twol
fi;
cp ../apertium-kir/apertium-kir.kir.rlx apertium-kaz-kir.kir-kaz.rlx

exit 0


