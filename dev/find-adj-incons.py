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

adj = re.compile(' ([AN][0-9]+) ;');

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
		print('2:', lem, cont);
	#}
#}

print(len(l1adj), file=sys.stderr);
print(len(l2adj), file=sys.stderr);

adj = re.compile('<s n="adj"/>');

llem = re.compile('<l>(.+)</l>');
rlem = re.compile('<r>(.+)</r>');

combos = {};

for line in bd.readlines(): #{
	if line.count('<e') < 1: #{
		continue;
	#}
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

		if (contl, contr) not in combos: #{
			combos[(contl, contr)] = 0;
		#}
		combos[(contl, contr)] = combos[(contl, contr)] + 1;

		if contl != contr: #{
			print('C:\t%s\t%s\t%s ||| \t%s\t%s\t%s' % ( bdl, contl, bdlt, bdr, contr, bdrt));
		else: #{
			print('B:\t%s\t%s\t%s ||| \t%s\t%s\t%s' % ( bdl, contl, bdlt, bdr, contr, bdrt));
		#}
	#}	
#}

# apertium-kaz:

# A1: adj, adj.comp, adj.subst, adj.comp.subst, adj.advl, adj.comp.advl
# A2: adj, adj.comp, adj.subst, adj.comp.subst
# A3: adj, adj.subst
# A4: adj
# A5: -
# A6: adj, adj.subst, adj.advl

# apertium-kir:

# A1: adj, adj.comp, adj.subst, adj.comp.subst, adj.advl, adj.comp.advl
# A2: adj, adj.comp, adj.subst, adj.comp.subst
# A3: adj, adj.subst
# A4: adj
# A5: adj, adj.comp
# A6: adj, adj.subst, adj.advl

for p in combos: #{
	print('%s\t%s %s' % (combos[p], p[0], p[1]));
#}

templ = {
	'A4:A4':'', # 275
	'A1:A1':'', # 181
	'A2:A2':'', # 81
	'A3:A3':'', # 75
	'A4:A3':'', # 71
	'A1:A4':'', # 25
	'A2:A3':'', # 24
	'A1:A3':'', # 22
	'A1:@@':'', # 13
	'A4:A2':'', # 12
	'A1:A2':'', # 12
	'A3:A2':'', # 7
	'A2:A1':'', # 7
	'A4:A1':'', # 6
	'A3:A4':'', # 6
	'@@:A3':'', # 6
	'A1:A6':'', # 6
	'A6:A6':'', # 5
	'A3:@@':'', # 5
	'@@:@@':'', # 5
	'A2:A4':'', # 4
	'A2:@@':'', # 4
	'@@:A2':'', # 3
	'@@:A1':'', # 3
	'A6:A3':'', # 2
	'A6:A1':'', # 2
	'A3:A1':'', # 2
	'A6:A4':'', # 1
	'A6:@@':'', # 1
	'A4:A6':'', # 1
	'A4:A5':'', # 1
	'A4:@@':'', # 1
	'@@:A4':'', # 1
	'A1:A5':'' # 1
};
