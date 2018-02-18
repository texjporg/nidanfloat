STRIPTARGET = nidanfloat.sty
DOCTARGET = nidanfloat
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
FONTMAP = -f ipaex.map -f ptex-ipaex.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

default: $(STRIPTARGET) $(DVITARGET)
strip: $(STRIPTARGET)
all: $(STRIPTARGET) $(PDFTARGET)

NIDAN = nidanfloat.sty

NIDAN_SRC = nidanfloat.dtx

# for generating files, we use pdflatex incidentally.
# current packages contain ASCII characters only, safe enough
nidanfloat.sty: $(NIDAN_SRC)
	rm -f $(NIDAN)
	pdflatex nidanfloat.ins
	rm nidanfloat.log

.SUFFIXES: .dtx .dvi .pdf
.dtx.dvi:
	platex $(KANJI) $<
	platex $(KANJI) $<
	rm -f *.aux *.log *.toc
.dvi.pdf:
	dvipdfmx $(FONTMAP) $<

.PHONY: install clean cleanstrip cleanall cleandoc
install:
	mkdir -p ${TEXMF}/doc/latex/nidanfloat
	cp ./LICENSE ${TEXMF}/doc/latex/nidanfloat/
	cp ./README.md ${TEXMF}/doc/latex/nidanfloat/
	cp ./*.pdf ${TEXMF}/doc/latex/nidanfloat/
	mkdir -p ${TEXMF}/source/latex/nidanfloat
	cp ./Makefile ${TEXMF}/source/latex/nidanfloat/
	cp ./*.dtx ${TEXMF}/source/latex/nidanfloat/
	cp ./*.ins ${TEXMF}/source/latex/nidanfloat/
	mkdir -p ${TEXMF}/tex/latex/nidanfloat
	cp ./*.sty ${TEXMF}/tex/latex/nidanfloat/
clean:
	rm -f $(NIDAN) $(DVITARGET)
cleanstrip:
	rm -f $(NIDAN)
cleanall:
	rm -f $(NIDAN) $(DVITARGET) $(PDFTARGET)
cleandoc:
	rm -f $(DVITARGET) $(PDFTARGET)
