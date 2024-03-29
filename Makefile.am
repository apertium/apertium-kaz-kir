###############################################################################
## Makefile for Kazakh--Kyrgyz
###############################################################################

LANG1=kaz
LANG2=kir
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
	$(PREFIX1).automorf.bin $(PREFIX1).autopgen.bin $(PREFIX1).autogen.bin $(PREFIX1).t1x.bin $(PREFIX1).t2x.bin \
	$(PREFIX2).automorf.bin $(PREFIX2).autopgen.bin $(PREFIX2).autogen.bin $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin \
        $(PREFIX1).rlx.bin $(PREFIX2).rlx.bin \
        $(PREFIX1).autolex.bin $(PREFIX2).autolex.bin \
        $(PREFIX1).autoseq.bin $(PREFIX2).autoseq.bin \
        $(PREFIX1).revautoseq.bin $(PREFIX2).revautoseq.bin

# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Kazakh→Kyrgyz monolingual transducers
###############################################################################

.deps/$(PREFIX1).autobil.prefixes: $(PREFIX1).autobil.bin .deps/.d
	lt-print $(PREFIX1).autobil.bin | sed 's/ /@_SPACE_@/g' > .deps/$(PREFIX1).autobil.att
	hfst-txt2fst -e ε <  .deps/$(PREFIX1).autobil.att > .deps/$(PREFIX1).autobil.hfst
	hfst-project -p upper .deps/$(PREFIX1).autobil.hfst > .deps/$(PREFIX1).autobil.upper
	echo " ?* " | hfst-regexp2fst > .deps/any-symbol.hfst
	hfst-concatenate -1 .deps/$(PREFIX1).autobil.upper -2 .deps/any-symbol.hfst -o .deps/$(PREFIX1).autobil.prefixes

$(PREFIX1).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.att.gz .deps/$(PREFIX1).autobil.prefixes .deps/.d
	$(ZCAT) $< | hfst-txt2fst > .deps/$(LANG1).automorf.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).automorf.hfst -2 .deps/$(PREFIX1).autobil.prefixes -o .deps/$(PREFIX1).automorf.trimmed
	hfst-fst2txt -i .deps/$(PREFIX1).automorf.trimmed -o .deps/$(PREFIX1).automorf.trimmed.att
	lt-comp lr .deps/$(PREFIX1).automorf.trimmed.att $@

#$(PREFIX1).autogen.bin: $(AP_SRC2)/$(LANG2).autogen.bin
#	cp $< $@

$(PREFIX1).autogen.bin: $(AP_SRC2)/$(LANG2).autogen.bin
	cp $< $@

###############################################################################
## Kyrgyz→Kazakh monolingual transducers
###############################################################################

.deps/$(PREFIX2).autobil.prefixes: $(PREFIX2).autobil.bin .deps/.d
	lt-print $(PREFIX2).autobil.bin | sed 's/ /@_SPACE_@/g' > .deps/$(PREFIX2).autobil.att
	hfst-txt2fst -e ε <  .deps/$(PREFIX2).autobil.att > .deps/$(PREFIX2).autobil.hfst
	hfst-project -p upper .deps/$(PREFIX2).autobil.hfst > .deps/$(PREFIX2).autobil.upper
	echo " ?* " | hfst-regexp2fst > .deps/any-symbol.hfst
	hfst-concatenate -1 .deps/$(PREFIX2).autobil.upper -2 .deps/any-symbol.hfst -o .deps/$(PREFIX2).autobil.prefixes

$(PREFIX2).automorf.bin: $(AP_SRC2)/$(LANG2).automorf.att.gz .deps/$(PREFIX2).autobil.prefixes .deps/.d
	$(ZCAT) $< | hfst-txt2fst > .deps/$(LANG2).automorf.hfst
	hfst-compose-intersect -1 .deps/$(LANG2).automorf.hfst -2 .deps/$(PREFIX2).autobil.prefixes -o .deps/$(PREFIX2).automorf.trimmed
	hfst-fst2fst -O .deps/$(PREFIX2).automorf.trimmed -o $@
	hfst-fst2txt -i .deps/$(PREFIX2).automorf.trimmed -o .deps/$(PREFIX2).automorf.trimmed.att
	lt-comp lr .deps/$(PREFIX2).automorf.trimmed.att $@

#$(PREFIX2).autogen.bin: $(AP_SRC1)/$(LANG1).autogen.bin
#	cp $< $@

$(PREFIX2).autogen.bin: $(AP_SRC1)/$(LANG1).autogen.bin
	cp $< $@

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

$(PREFIX1).rlx.bin: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).rlx
	cg-comp $< $@

$(PREFIX2).rlx.bin: $(AP_SRC2)/apertium-$(LANG2).$(LANG2).rlx
	cg-comp $< $@

###############################################################################
## Lexical sequences
###############################################################################

$(PREFIX1).autoseq.bin: $(BASENAME).$(PREFIX1).lsx
	lsx-comp lr $< $@

$(PREFIX2).autoseq.bin: $(BASENAME).$(PREFIX2).lsx
	lsx-comp lr $< $@

$(PREFIX1).revautoseq.bin: $(BASENAME).$(PREFIX1).lsx
	lsx-comp rl $< $@

$(PREFIX2).revautoseq.bin: $(BASENAME).$(PREFIX2).lsx
	lsx-comp rl $< $@

#	lt-print $(PREFIX1).autoseq.bin |  sed 's/ /@_SPACE_@/g' > $(PREFIX1).autoseq.att
#	hfst-txt2fst -e ε < $(PREFIX1).autoseq.att > $(PREFIX1).autoseq.hfst
#	hfst-invert $(PREFIX1).autoseq.hfst | hfst-minimise > $(PREFIX1).revautoseq.hfst
#	hfst-fst2txt $(PREFIX1).revautoseq.hfst | gzip -9 -c -n > $(PREFIX1).revautoseq.att.gz
#	zcat < $(PREFIX1).revautoseq.att.gz > $(PREFIX1).revautoseq.att
#	sed 's/@0@/ε/g' $(PREFIX1).revautoseq.att > $(PREFIX1).revautoseq.1.att
#	lt-comp lr $(PREFIX1).revautoseq.1.att $@


#$(PREFIX2).revautoseq.bin: $(BASENAME).$(PREFIX2).lsx
#	lt-print $(PREFIX2).autoseq.bin |  sed 's/ /@_SPACE_@/g' > $(PREFIX2).autoseq.att
#	hfst-txt2fst -e ε < $(PREFIX2).autoseq.att > $(PREFIX2).autoseq.hfst
#	hfst-invert $(PREFIX2).autoseq.hfst | hfst-minimise > $(PREFIX2).revautoseq.hfst
#	hfst-fst2txt $(PREFIX2).revautoseq.hfst | gzip -9 -c -n > $(PREFIX2).revautoseq.att.gz
#	zcat < $(PREFIX2).revautoseq.att.gz > $(PREFIX2).revautoseq.att
#	sed 's/@0@/ε/g' $(PREFIX2).revautoseq.att > $(PREFIX2).revautoseq.1.att
#	lt-comp lr $(PREFIX2).revautoseq.1.att $@

###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1).autolex.bin: $(BASENAME).$(PREFIX1).lrx
	apertium-validate-lrx $<
	lrx-comp $< $@

$(PREFIX2).autolex.bin: $(BASENAME).$(PREFIX2).lrx
	apertium-validate-lrx $<
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
## Distribution
###############################################################################

EXTRA_DIST=$(PREFIX1).prob $(PREFIX2).prob \
           $(BASENAME).$(PREFIX1).rlx \
           $(BASENAME).$(PREFIX1).dix \
           $(BASENAME).post-$(LANG1).dix \
           $(BASENAME).$(PREFIX2).lrx \
           $(BASENAME).post-$(LANG2).dix \
           $(BASENAME).$(PREFIX1).t1x \
           $(BASENAME).$(PREFIX1).t2x \
           $(BASENAME).$(PREFIX2).t1x \
           $(BASENAME).$(PREFIX2).t2x \
           modes.xml

###############################################################################
## Installation
###############################################################################

apertium_kaz_kirdir=$(prefix)/share/apertium/$(BASENAME)/

apertium_kaz_kir_DATA=$(TARGETS_COMMON) \
	$(BASENAME).$(PREFIX1).t1x \
	$(BASENAME).$(PREFIX1).t2x \
	$(BASENAME).$(PREFIX2).t1x \
	$(BASENAME).$(PREFIX2).t2x \
                    $(PREFIX1).prob $(PREFIX2).prob

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode


install-data-local: install-modes

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	apertium-regtest test
