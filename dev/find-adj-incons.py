import sys, re;

# $ python3 find-adj-incons.py ~/source/apertium/languages/apertium-kaz/apertium-kaz.kaz.lexc ~/source/apertium/languages/apertium-kir/apertium-kir.kir.lexc ../apertium-kaz-kir.kaz-kir.dix  

def cleanxml(s): #{

	o = s;
	o = o.replace('<b/>', ' ');
	o = o.replace('<b />', ' ');
	return o;
#}

def clean(s): #{

	o = s;
	o = o.replace('% ', ' ');
	o = o.replace('%-', '-');

	return o;
#}

l1 = open(sys.argv[1]);
l2 = open(sys.argv[2]); 
bd = open(sys.argv[3]);

adj = re.compile(' (A[0-9]+) ;');

l1adj = {};

for line in l1.readlines(): #{
	if adj.search(line): #{
		if line[0] == '!': #{
			continue;
		#}
		lem = clean(line.split(':')[0]);
		cont = adj.findall(line)[0];
		l1adj[lem] = cont;
#		print('1:', lem, cont);
	#}
#}

l2adj = {};

for line in l2.readlines(): #{

	if adj.search(line): #{
		if line[0] == '!': #{
			continue;
		#}
		lem = clean(line.split(':')[0]);
		cont = adj.findall(line)[0];
		l2adj[lem] = cont;
#		print('2:', lem, cont);
	#}
#}

print(len(l1adj), file=sys.stderr);
print(len(l2adj), file=sys.stderr);

adj = re.compile('<s n="adj"/>');

llem = re.compile('<l>(.+)</l>');
rlem = re.compile('<r>(.+)</r>');

for line in bd.readlines(): #{

	if adj.search(line): #{
		bdl = cleanxml(llem.findall(line)[0]);
		bdr = cleanxml(rlem.findall(line)[0]);
		bdlt = '<' + '<'.join(bdl.split('<')[1:]);
		bdrt = '<' + '<'.join(bdr.split('<')[1:]);
		bdl = bdl.split('<')[0];
		bdr = bdr.split('<')[0];
		contl = '@@';
		contr = '@@';
		if bdl in l1adj: #{
			contl = l1adj[bdl];
		#}

		if bdr in l2adj: #{
			contr = l2adj[bdr];
		#}

		if contl != contr: #{
			print('C:\t%s\t%s\t%s ||| \t%s\t%s\t%s' % ( bdr, contl, bdlt, bdl, contr, bdrt));
		else: #{
			print('B:\t%s\t%s\t%s ||| \t%s\t%s\t%s' % ( bdr, contl, bdlt, bdl, contr, bdrt));
		#}
	#}	
#}
