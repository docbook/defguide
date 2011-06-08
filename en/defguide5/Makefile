include $(DOCBOOK_SVN)/buildtools/Makefile.incl

SSTITLEPG=style/html-titlepage.xsl
SSCHUNK=style/chunk.xsl
SSFO=style/tdgfo.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=build/
ROOTID=
FORESULT=chunk.fo
STYLEOPT=
HTMLEXT=.html
TIDY=tidy

DIFFVER=

FMGO=-N

XSLTOPT=base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)

ifeq ($(ROOTID),)
  ROOTIDPARAM=
else
  ROOTIDPARAM=rootid=$(ROOTID)
endif

ifeq ($(XSLT),xsltproc)
  MEMORYOPT=
else
  MEMORYOPT=-opts hugemem
endif

.PHONY: refpages

all: chunks

test: book.xml
	jing ../../docbook/relaxng/docbook/docbook.rng $<

patterns.xml: lib/patterns.xml ../stylesheets/patterns.xsl
	$(XSLT) $< ../stylesheets/patterns.xsl $@

tdg.xml: refpages book5.xml bookinfo.xml patterns.xml \
         refpages/references.xml refpages/list-elements.xml \
         refpages/intro-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/*.fmt)
	xmllint --nowarning --xinclude book5.xml > $@

profiled.xml: tdg.xml ../stylesheets/profile.xsl
	$(XSLT) $< ../stylesheets/profile.xsl $@ not-condition="compact print"

book.xml: profiled.xml style/purpose.xsl ../stylesheets/purpose.xsl
	$(XSLT) $< style/purpose.xsl $@

refpages:
	make -C refpages

setup:
	mkdir -p build build/css build/js
	cp ../css/*.css build/css/
	cp ../script/*.js build/js/

# Warning: this might only work on Unix
chunks: $(SOURCE) $(SSTITLEPG) book.xml setup
	rm -rf figs && mkdir -p figs && cd ../figs && tar cf - web | (cd ../defguide5/figs; tar xf -)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT)
	rm -rf build/figs && mv figs build/
	cd $(BASEDIR) && $(TIDY) *.html
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT) rootid=index

chunk: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT) $(ROOTIDPARAM)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT) rootid=index

style/html-titlepage.xsl: style/html-titlepage.xml
	$(XSLT) $< /sourceforge/docbook/xsl/template/titlepage.xsl $@

fochunks:
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partI.fo rootid=docbook-intro $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partII.fo rootid=docbook-reference $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partIII.fo rootid=docbook-apps $(STYLEOPT)

fochunk:
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) $(FORESULT) $(ROOTIDPARAM) $(STYLEOPT)

%.pdf: %.fo
	xep $<

tdg.fo: tdg.xml
	$(XSLT) $(MEMORYOPT) $< $(SSFO) $@ $(ROOTIDPARAM) $(STYLEOPT)

tdg.pdf: tdg.fo
	xep $< $@

clean:
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml book.xml
	rm -rf build

