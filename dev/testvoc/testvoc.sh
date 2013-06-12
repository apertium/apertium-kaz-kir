if [[ $1 = "kir-kaz" ]]; then
echo "==Kyrgyz->Kazakh===========================";
bash inconsistency.sh kir-kaz > /tmp/kir-kaz.testvoc; bash inconsistency-summary.sh /tmp/kir-kaz.testvoc kir-kaz
echo ""

elif [[ $1 = "kaz-kir" ]]; then
echo "==Kazakh->Kyrgyz===========================";
bash inconsistency.sh kaz-kir > /tmp/kaz-kir.testvoc; bash inconsistency-summary.sh /tmp/kaz-kir.testvoc kaz-kir

fi
