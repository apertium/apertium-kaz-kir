TMPDIR=/tmp

DIR=$1

if [[ $DIR = "kir-kaz" ]]; then

hfst-fst2strings ../../kir-kaz.automorf.hfst | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../kir-kaz.autobil.bin |  tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-kaz-kir.kir-kaz.t1x  ../../kir-kaz.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        hfst-proc -d ../../kir-kaz.autogen.hfst > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'

elif [[ $DIR = "kaz-kir" ]]; then

hfst-fst2strings ../../kaz-kir.automorf.hfst | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../kaz-kir.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-kaz-kir.kaz-kir.t1x  ../../kaz-kir.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        hfst-proc -d ../../kaz-kir.autogen.hfst > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt| sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'


else
	echo "bash inconsistency.sh <direction>";
fi
