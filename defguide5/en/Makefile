include ../../cvstools/Makefile.incl

SSTITLEPG=stylesheets/html-titlepage.xsl
SSCHUNK=stylesheets/chunk.xsl
SSFO=stylesheets/tdgfo.xsl

SOURCE=tdg-stripped.xml
MEMORY=100000000
BASEDIR=../html/
ROOTID=
FORESULT=chunk.fo
STYLEOPT=
HTMLEXT=.html

DIFFVER=

FMGO=-N

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

all: chunks

test: tdg.xml
	jing ../../docbook/relaxng/docbook/docbook.rng $<

tdg.xml: book.xml bookinfo.xml refpages/list-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/build/*.xml)
	xmllint --xinclude book.xml > $@

tdg-stripped.xml: tdg.xml
	xsltproc --output $@ stylesheets/strip.xsl $<

bookinfo.xml: VERSION.xml
	$(XSLT) $< $< $@

chunks: $(SOURCE) $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index $(STYLEOPT)

chunk: $(SOURCE) $(SSTITLEPG) tdg-stripped.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(ROOTIDPARAM) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index

stylesheets/html-titlepage.xsl: stylesheets/html-titlepage.xml
	$(XSLT) $< ../../xsl/template/titlepage.xsl $@

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
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml

freshmeat:
	$(XSLT) VERSION.xml VERSION.xml /tmp/fm-docbook-tdg freshmeat=1
	grep -v "<?xml" /tmp/fm-docbook-tdg | freshmeat-submit $(FMGO)

WhatsNew:
	$(CVS2LOG) -w
ifeq ($(DIFFVER),)
	$(MERGELOGS) > $@
else
	$(MERGELOGS) -v $(DIFFVER) > $@
endif
