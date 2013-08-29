###############################################################################
## Makefile for Kazakh--Kyrgyz
###############################################################################

VERSION=0.2.0
LANG1=kaz
LANG2=kir
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
	$(PREFIX1).automorf.bin $(PREFIX1).autopgen.bin $(PREFIX1).autogen.hfst $(PREFIX1).t1x.bin $(PREFIX1).t2x.bin \
	$(PREFIX2).automorf.hfst $(PREFIX2).autopgen.bin $(PREFIX2).autogen.hfst $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin \
        $(PREFIX1).rlx.bin $(PREFIX2).rlx.bin \
        $(PREFIX1).lrx.bin $(PREFIX2).lrx.bin \
	$(PREFIX1).mode $(PREFIX2).mode modes 

###############################################################################
## Kazakh transducer
###############################################################################

.deps/$(PREFIX1).autobil.prefixes: $(PREFIX1).autobil.bin
	if [ ! -d .deps ]; then mkdir .deps; fi
	lt-print $(PREFIX1).autobil.bin | sed 's/ /@_SPACE_@/g' > .deps/$(PREFIX1).autobil.att
	hfst-txt2fst -e ε <  .deps/$(PREFIX1).autobil.att > .deps/$(PREFIX1).autobil.hfst
	hfst-project -p upper .deps/$(PREFIX1).autobil.hfst > .deps/$(PREFIX1).autobil.upper
	echo " ?* " | hfst-regexp2fst > .deps/any-symbol.hfst
	hfst-concatenate -1 .deps/$(PREFIX1).autobil.upper -2 .deps/any-symbol.hfst -o .deps/$(PREFIX1).autobil.prefixes

$(PREFIX1).automorf.bin: $(BASENAME).$(PREFIX1).LR.att.gz .deps/$(PREFIX1).autobil.prefixes
	$(ZCAT) $< | hfst-txt2fst > .deps/$(LANG1).automorf.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).automorf.hfst -2 .deps/$(PREFIX1).autobil.prefixes -o .deps/$(PREFIX1).automorf.trimmed
	hfst-fst2txt -i .deps/$(PREFIX1).automorf.trimmed -o .deps/$(PREFIX1).automorf.trimmed.att
	lt-comp lr .deps/$(PREFIX1).automorf.trimmed.att $@

$(PREFIX1).autogen.hfst: $(BASENAME).$(PREFIX1).RL.att.gz
	$(ZCAT) $< | hfst-txt2fst | hfst-fst2fst -O -o $@

###############################################################################
## Kyrgyz transducer
###############################################################################

.deps/$(PREFIX2).autobil.prefixes: $(PREFIX2).autobil.bin
	if [ ! -d .deps ]; then mkdir .deps; fi
	lt-print $(PREFIX2).autobil.bin | sed 's/ /@_SPACE_@/g' > .deps/$(PREFIX2).autobil.att
	hfst-txt2fst -e ε <  .deps/$(PREFIX2).autobil.att > .deps/$(PREFIX2).autobil.hfst
	hfst-project -p upper .deps/$(PREFIX2).autobil.hfst > .deps/$(PREFIX2).autobil.upper
	echo " ?* " | hfst-regexp2fst > .deps/any-symbol.hfst
	hfst-concatenate -1 .deps/$(PREFIX2).autobil.upper -2 .deps/any-symbol.hfst -o .deps/$(PREFIX2).autobil.prefixes

$(PREFIX2).automorf.hfst: $(BASENAME).$(PREFIX2).LR.att.gz .deps/$(PREFIX2).autobil.prefixes
	$(ZCAT) $< | hfst-txt2fst > .deps/$(LANG1).automorf.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).automorf.hfst -2 .deps/$(PREFIX2).autobil.prefixes -o .deps/$(PREFIX2).automorf.trimmed
	hfst-fst2txt -i .deps/$(PREFIX2).automorf.trimmed -o .deps/$(PREFIX2).automorf.trimmed.att
	hfst-txt2fst -i .deps/$(PREFIX2).automorf.trimmed.att | hfst-fst2fst -O -o $@
#	lt-comp lr .deps/$(PREFIX2).automorf.trimmed.att $@

$(PREFIX2).autogen.hfst: $(BASENAME).$(PREFIX2).RL.att.gz
	$(ZCAT) $< | hfst-txt2fst | hfst-fst2fst -O -o $@

###############################################################################
## Bilingual dictionaries
###############################################################################

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp lr $< $@

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $< 
	lt-comp rl $< $@

###############################################################################
## Disambiguation rules 
###############################################################################

$(PREFIX1).rlx.bin: $(BASENAME).$(PREFIX1).rlx
	cg-comp $< $@

$(PREFIX2).rlx.bin: $(BASENAME).$(PREFIX2).rlx
	cg-comp $< $@


###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1).lrx.bin: $(BASENAME).$(PREFIX1).lrx
	lrx-comp $< $@

$(PREFIX2).lrx.bin: $(BASENAME).$(PREFIX2).lrx
	lrx-comp $< $@

###############################################################################
## Structural transfer rules
###############################################################################

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t2x $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t2x $@

###############################################################################
## Postgeneration dictionaries
###############################################################################

$(PREFIX1).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	apertium-validate-dictionary $<
	lt-comp lr $< $@

$(PREFIX2).autopgen.bin: $(BASENAME).post-$(LANG2).dix
	apertium-validate-dictionary $< 
	lt-comp lr $< $@

###############################################################################
## Translation modes
###############################################################################

modes/$(PREFIX1).mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

modes/$(PREFIX2).mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

EXTRA_DIST=$(PREFIX1).prob $(PREFIX2).prob \
           $(BASENAME).$(PREFIX1).rlx \
           $(BASENAME).$(PREFIX1).lrx \
           $(BASENAME).$(PREFIX1).LR.att.gz \
           $(BASENAME).$(PREFIX1).RL.att.gz \
           $(BASENAME).$(PREFIX2).LR.att.gz \
           $(BASENAME).$(PREFIX2).RL.att.gz \
           $(BASENAME).$(PREFIX1).dix \
           $(BASENAME).post-$(LANG1).dix \
           $(BASENAME).$(PREFIX2).rlx \
           $(BASENAME).$(PREFIX2).lrx \
           $(BASENAME).post-$(LANG2).dix \
           $(BASENAME).$(PREFIX1).t1x \
           $(BASENAME).$(PREFIX1).t2x \
           $(BASENAME).$(PREFIX2).t1x \
           $(BASENAME).$(PREFIX2).t2x \
           modes.xml

apertium_kaz_kirmodesdir=$(prefix)/share/apertium/modes/
apertium_kaz_kirdir=$(prefix)/share/apertium/$(BASENAME)/

apertium_kaz_kir_DATA=$(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
                    $(PREFIX1).prob $(PREFIX2).prob \
		    $(PREFIX1).autogen.hfst $(PREFIX2).autogen.hfst \
		    $(PREFIX1).automorf.bin $(PREFIX2).automorf.hfst \
		    $(PREFIX1).autopgen.bin $(PREFIX2).autopgen.bin \
		    $(PREFIX1).t1x.bin $(PREFIX2).t1x.bin \
		    $(PREFIX1).t2x.bin $(PREFIX2).t2x.bin \
		    $(PREFIX1).rlx.bin $(PREFIX2).rlx.bin \
		    $(PREFIX1).lrx.bin $(PREFIX2).lrx.bin \
		    $(BASENAME).$(PREFIX1).t1x $(BASENAME).$(PREFIX2).t1x \
		    $(BASENAME).$(PREFIX1).t2x $(BASENAME).$(PREFIX2).t2x \
		    modes.xml

noinst_DATA=modes/$(PREFIX1).mode modes/$(PREFIX2).mode


install-data-local:
	mv modes modes~
	$(prefix)/bin/apertium-gen-modes modes.xml $(BASENAME)
	rm -rf modes
	mv modes~ modes
	test -d $(DESTDIR)$(apertium_kaz_kirmodesdir) || mkdir $(DESTDIR)$(apertium_kaz_kirmodesdir)
	$(INSTALL_DATA) $(PREFIX1).mode $(DESTDIR)$(apertium_kaz_kirmodesdir)
	rm $(PREFIX1).mode
	rm $(PREFIX2).mode
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(DESTDIR)$(apertium_kaz_kirdir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t2x $(DESTDIR)$(apertium_kaz_kirdir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX2).t1x $(DESTDIR)$(apertium_kaz_kirdir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX2).t2x $(DESTDIR)$(apertium_kaz_kirdir)

CLEANFILES = -r $(TARGETS_COMMON) .deps/
