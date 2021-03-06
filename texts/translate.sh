TMPDIR=/tmp
for i in *.kaz.txt; do 
	prefix=`echo $i | cut -f1 -d'.'`;

	if [ ! -e $prefix.kir.txt ]; then
		continue; 
	fi

	cat $i | apertium -d ../ kaz-kir > $TMPDIR/$prefix.kaz-kir.txt
	for j in $prefix.kir.*; do
		echo -ne "$prefix\t$j\t";
		apertium-eval-translator-line -t $TMPDIR/$prefix.kaz-kir.txt -r $j | grep -e WER -e PER | head -2 | tr '\n' '\t' | sed 's/Word error rate//g' | sed 's/Position-independent word error rate//g'
		echo ""
	done
done

apertium-eval-translator-line -t $TMPDIR/story.kaz-kir.txt -r story.kaz-kir-postedited.2.txt
