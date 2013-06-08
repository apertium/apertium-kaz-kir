BIDIX=apertium-kaz-tat.kaz-tat.dix
BILTRANS=kaz-kir-biltrans

for i in `cat $BIDIX  | sed 's/ //g' | sed 's/<l>/@/g' | sed 's/<\/\?r>/@/g' | cut -f2,3 -d'@' | sed 's/<\/l>//g' | grep '<e'`; do 
	L=`echo $i | cut -f1 -d'@'`; 
	R=`echo $i | cut -f2 -d'@'`; 
	if [[ "$L" == "$R" ]]; then 
		echo $L >> /tmp/$BIDIX.same; 
	fi; 
done 

cat /tmp/$BIDIX.same | uniq | sed 's/<sn/<s n/g' | grep '<s' > /tmp/$BIDIX.same.uniq
cat /tmp/$BIDIX.same.uniq | cut -f1 -d'<' | sed 's/$/\t./g' | apertium -d . $BILTRANS > /tmp/$BIDIX.biltrans
paste /tmp/$BIDIX.biltrans /tmp/$BIDIX.same.uniq | grep -e '@' -e '\*'  | cut -f3 > /tmp/$BIDIX.same.intersect
paste /tmp/$BIDIX.same.intersect /tmp/$BIDIX.same.intersect | sed 's/^/    <e><p><l>/g' | sed 's/\t/<\/l><r>@/g' | sed 's/$/<\/r><\/p><\/e>/g' | uniq > /tmp/kaz-kir
